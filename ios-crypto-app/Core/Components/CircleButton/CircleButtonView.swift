//
//  CircleButtonView.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 19/03/25.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String;
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .padding()
            .frame(width:50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.2),
                radius: 10, x:0, y:0
            )
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        CircleButtonView(iconName: "info")
            .previewLayout(.sizeThatFits)
        
    }
}
