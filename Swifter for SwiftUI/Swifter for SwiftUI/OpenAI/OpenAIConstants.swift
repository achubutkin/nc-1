//
//  OpenAIConstants.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 17/11/23.
//

import Foundation

struct OpenAIConstants {
    static let openAISecretKey = Bundle.main.infoDictionary?["OPENAI_API_SECRET_KEY"] as? String
    static let openAIChatGPTModel = "gpt-3.5-turbo"
}
