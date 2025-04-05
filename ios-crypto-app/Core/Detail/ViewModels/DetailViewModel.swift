//
//  DetailViewModel.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 05/04/25.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    
    private let coinDetailService: CoinDetailDataService
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
    
}
