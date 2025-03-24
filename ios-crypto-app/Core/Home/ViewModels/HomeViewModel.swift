//
//  HomeViewModel.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 20/03/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        //        dataService.$allCoins
        //            .sink { [weak self] returnedCoins in
        //                self?.allCoins = returnedCoins
        //            }
        //            .store(in: &cancellables)
        
        
        // UPDATES ALL COINS
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // UPDATES MARKET DATA
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink(receiveValue: { [weak self] returnedStats in
                self?.statistics = returnedStats
            })
            .store(in: &cancellables)
        
        // UPDATES PORTFOLIO COINS
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoin)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        
        guard !text.isEmpty else {
            return coins
        }
        
        
        let lowercasedText = text.lowercased()
        
        return coins.filter {
            $0.name.lowercased().contains(lowercasedText) ||
            $0.symbol.lowercased().contains(lowercasedText) ||
            $0.id.lowercased().contains(lowercasedText)
        }
    }
    
    
    private func mapAllCoinsToPortfolioCoin(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity])  -> [CoinModel]{
        allCoins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
            
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volume = StatisticModel(title: "24H Volume", value: data.volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        
        let portfolioValue = portfolioCoins.map { coin -> Double in
            coin.currentHoldingsValue
        }.reduce(0, +)
        
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentvalue = coin.currentHoldingsValue
            let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
            
            let previousValue = currentvalue / (1 + percentChange)
            
            return previousValue
        }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats
    }
    
}


