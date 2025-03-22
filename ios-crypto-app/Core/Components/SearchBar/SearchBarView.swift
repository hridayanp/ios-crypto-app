//
//  SearchBarView.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 22/03/25.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("Search here...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .overlay(
                    HStack {
                        Spacer() // Pushes the icon to the trailing edge
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.theme.accent)
                            .padding(10)
                            // .background(Color.theme.red)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .offset(x: 10)
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                                searchText = ""
                            }
                    }
                        .padding(.trailing, 2)
                )
            
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.1),
                    radius: 10, x:0, y:10
                )
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            
            
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
        }
    }
}
