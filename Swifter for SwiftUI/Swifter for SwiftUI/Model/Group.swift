//
//  ComponentItem.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 15/11/23.
//

import Foundation

import Foundation
import SwiftUI
import CoreLocation

struct Group: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var components: [Component]
}
