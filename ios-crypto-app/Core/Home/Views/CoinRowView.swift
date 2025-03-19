//
//  CoinRowView.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 19/03/25.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            
            Spacer()
            
            if(showHoldingsColumn) {
                centerColumn
                Spacer()
            }
            
            rightColumn
            
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: developerPreview.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: developerPreview.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            Circle()
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.horizontal)
                .foregroundColor(Color.theme.accent)
            
            Spacer()
        }
    }
    
    
    private var centerColumn: some View {
        VStack {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold().foregroundColor(Color.theme.accent)
            
            Text((coin.currentHoldings ?? 0).asNumberString())
                .bold()
                .foregroundColor((coin.priceChangePercentage24H ?? 0) > 0 ? Color.theme.green : Color.theme.red)
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold().foregroundColor(Color.theme.accent)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0.00%")
                .bold()
                .foregroundColor((coin.priceChangePercentage24H ?? 0) > 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
