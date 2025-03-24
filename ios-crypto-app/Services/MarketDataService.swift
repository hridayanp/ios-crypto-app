//
//  MarketDataService.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 23/03/25.
//

import Foundation

import Foundation
import Combine


class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        
        guard let API_URL = URL(string: "https://api.coingecko.com/api/v3/global")
        else { return }
        
        marketDataSubscription = NetworkingManager.download(url: API_URL)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
