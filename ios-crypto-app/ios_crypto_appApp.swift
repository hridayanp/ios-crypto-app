//
//  ios_crypto_appApp.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 16/03/25.
//

import SwiftUI

@main
struct ios_crypto_appApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView().navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
