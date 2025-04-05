//
//  CoinDetailDataService.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 05/04/25.
//

import Foundation
import Combine


class CoinDetailDataService {
    @Published var coinDetails: CoinDetailModel? = nil
    
    let coin: CoinModel
    
    var coinDetailSubscription: AnyCancellable?
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        
        
        
        
        guard let API_URL = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else { return }
        
        coinDetailSubscription = NetworkingManager.download(url: API_URL)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
