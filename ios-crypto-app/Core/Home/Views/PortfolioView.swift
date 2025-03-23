//
//  PortfolioView.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 23/03/25.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioForm
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavbarItems
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(developerPreview.homeVM)
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coins in
                    CoinLogoView(coin: coins)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture(perform: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedCoin = coins
                            }
                        })
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coins.id ? Color.theme.green : Color.clear,
                                    lineWidth: 1.0
                                )
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        })
    }
    
    
    private var portfolioForm: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                Spacer()
                
                Text("\(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "") ")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex. 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal, 2)
            }
            Divider()
            HStack {
                Text("Current values: ")
                Spacer()
                
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .padding()
        .font(.headline)
    }
    
    
    private var trailingNavbarItems: some View {
        HStack(spacing: 1) {
            
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                showCheckmark.toggle()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
            )
            
        }
        .font(.headline)
    }
    
    
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        
        return 0
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin else { return }
        
        //save to portfolio
        
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        })

    }
    
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
