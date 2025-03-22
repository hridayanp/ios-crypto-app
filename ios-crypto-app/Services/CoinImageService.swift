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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    var imageSubscription: AnyCancellable?
    
    private let coin: CoinModel
    
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        
        getCoinImage()
        
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("FROM APP MANAGER")
        }
        else {
            downloadCoinImage()
            print("FROM NETWORK")
        }
    }
    
    private func downloadCoinImage() {
        guard let API_URL = URL(string: coin.image)
        else { return }
        
        imageSubscription = NetworkingManager.download(url: API_URL)
            .tryMap({ (data) -> UIImage in
                return UIImage(data: data)!
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self else { return }
                
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: returnedImage, imageName: imageName, folderName: folderName)
            })
        
        
    }
}
