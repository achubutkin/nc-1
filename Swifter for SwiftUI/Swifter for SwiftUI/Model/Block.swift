//
//  Block.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 16/11/23.
//

import Foundation

enum BlockTypes: String, CaseIterable, Codable {
    case text = "text"
    case code = "code"
    case preview = "preview"
    case codeBlockAndPreview = "codeBlockAndPreview"
}

struct Block: Hashable, Codable {
    var type: BlockTypes
    var content: String
    var aiCodeGeneratorPrompt: String?
    var previewComponent: String?
}
