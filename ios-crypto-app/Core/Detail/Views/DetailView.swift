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
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private var spacing: CGFloat = 20
    
    init(coin: CoinModel) {
        
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        
        print("View of coin \(_vm)")
    }
    
    var body: some View {
        ScrollView {
            
            VStack(spacing:20) {
                Text("")
                    .frame(height: 150)
                
                
                overviewTitle
                Divider()
                
                overviewLazyGrid
                
               
                
                additionalTitle
                Divider()
                
                additionalLazyGrid
                
                
                
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: (developerPreview.coin))
        }
        
    }
}

extension DetailView {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewLazyGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                    
                }
            }
    }
    
    
    private var additionalLazyGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                    
                }
            }
    }
}
