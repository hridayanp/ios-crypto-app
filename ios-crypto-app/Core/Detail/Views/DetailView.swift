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
    
    @StateObject var vm: DetailViewModel
    
   
    
    init(coin: CoinModel) {
        
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        
        print("View of coin \(_vm)")
    }
    
    var body: some View {
        Text("HELLO")
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: (developerPreview.coin))
    }
}
