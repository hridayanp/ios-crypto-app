//
//  DetailView.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 24/03/25.
//

import SwiftUI

struct DetailLoadingView:  View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                Text(coin.name)
            } else {
                Text("Loading...")
            }
        }
        
    }
    
    
}

struct DetailView: View {
    
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
    }
    
    var body: some View {
        Text(coin.name)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: (developerPreview.coin))
    }
}
