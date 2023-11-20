//
//  Item.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 14/11/23.
//

import Foundation
import SwiftData

@Model
final class SwiftComponent {
    var timestamp: Date
    var title: String
    
    init(timestamp: Date, title: String) {
        self.timestamp = timestamp
        self.title = title
    }
}
