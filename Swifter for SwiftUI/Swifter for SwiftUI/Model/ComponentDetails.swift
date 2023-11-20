//
//  ComponentDetails.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 16/11/23.
//

import Foundation

struct ComponentDetails: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var shortDescription: String
    var fullDescription: String
    var blocks: [Block]? = []
}
