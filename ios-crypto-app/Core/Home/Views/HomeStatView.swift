//
//  HomeStatView.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 23/03/25.
//

import SwiftUI

struct HomeStatView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { statistic in
                StatisticView(stat: statistic)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment:
                showPortfolio ? .trailing : .leading
        )
    }
}

struct HomeStatView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatView(showPortfolio: .constant(false))
            .environmentObject(developerPreview.homeVM)
    }
}
