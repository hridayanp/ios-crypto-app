//
//  CoinImageService.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 22/03/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    
    private let coin: CoinModel
    
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let API_URL = URL(string: coin.image)
        else { return }
        
        imageSubscription = NetworkingManager.download(url: API_URL)
            .tryMap({ (data) -> UIImage in
                return UIImage(data: data)!
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
        
        
    }
}
