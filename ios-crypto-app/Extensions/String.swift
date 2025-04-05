//
//  String.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 05/04/25.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
