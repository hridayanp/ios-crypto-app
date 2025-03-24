//
//  HapticManager.swift
//  ios-crypto-app
//
//  Created by Hridayan Phukan on 24/03/25.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
