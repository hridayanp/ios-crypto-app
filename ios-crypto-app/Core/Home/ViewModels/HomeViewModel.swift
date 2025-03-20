//
//  HomeViewModel.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 20/03/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
