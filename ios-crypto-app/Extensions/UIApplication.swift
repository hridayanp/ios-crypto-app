//
//  UIApplication.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 22/03/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
