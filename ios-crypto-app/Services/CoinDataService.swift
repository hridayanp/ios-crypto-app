//
//  CoinDataService.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 20/03/25.
//

import Foundation
import Combine


class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    init() {
        getCoins()
    }
    
    func getCoins() {
        
        guard let API_URL = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else { return }
        
        coinSubscription = NetworkingManager.download(url: API_URL)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
