//
//  Component.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 15/11/23.
//

import Foundation

struct Component: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var locked: Bool?
}
