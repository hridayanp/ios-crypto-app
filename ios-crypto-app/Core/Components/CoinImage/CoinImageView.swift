//
//  CoinImageView.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 22/03/25.
//

import SwiftUI



struct CoinImageView: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            else if vm.isLoading {
                ProgressView()
            }
            else {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Preview: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: developerPreview.coin).padding()
            .previewLayout(.sizeThatFits)
    }
}
