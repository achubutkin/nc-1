//
//  OpenAI.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 17/11/23.
//

import Foundation
import SwiftUI

struct OpenAI {
    private var openAIHost = "https://api.openai.com/v1"
    private var openAICreateChatCompletion = "/chat/completions"
    
    @State var isRequestInProgress = false
    @State var isRequestReceivedFirstMessage = false
    
    // TODO: can lines be changed by user?
    private var predefinedSystemOpenAIMessage = OpenAIRequestMessage(role: .system, content: "Generate a very short, interesting, custom code example for a component in Swift UI. With preview. With import Swift UI namespace. Without any text. Without markdown symbols. Maximum 20 code lines.")
    
    func fetchChatCompletion(message: String, receiveHandler: @escaping (String) -> Void) async throws -> Void {
        if isRequestInProgress {
            return
        }
        isRequestInProgress = true
        
        guard let uploadData = try? JSONEncoder().encode(OpenAIRequestBody(
            messages: [
                predefinedSystemOpenAIMessage,
                OpenAIRequestMessage(role: OpenAIRequestMessageRole.user, content: message)
            ],
            stream: true
        )) else {
            throw OpenAIError.invalidRequestData
        }
        let url = URL(string: "\(openAIHost)\(openAICreateChatCompletion)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = uploadData
        request.setValue("Bearer \(OpenAIConstants.openAISecretKey!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let (stream, response) = try await session.bytes(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw OpenAIError.executeRequest
        }
        
        for try await line in stream.lines {
            isRequestReceivedFirstMessage = true
            guard let message = parse(line) else {
                continue
            }
            receiveHandler(message)
        }
        
        isRequestInProgress = false
        isRequestReceivedFirstMessage = false
        
        // TODO: previous version without stream output
        /*
        return OpenAIResponseBody(id: "", object: "", created: 0, model: "", usage: OpenAIResponseUsage(prompt_tokens: 0, completion_tokens: 0, total_tokens: 0))

        guard let (data, response) = try? await session.upload(for: request, from: uploadData),
              let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
        else {
            throw OpenAIError.executeRequest
        }
        
        do {
            let string = String(data: data, encoding: .utf8)
            print(string!)
            return try JSONDecoder().decode(OpenAIResponseBody.self, from: data)
        }
        catch {
            throw OpenAIError.wrongResponseDataFormat
        }
        */
    }
    
    // TODO: https://zachwaugh.com/posts/streaming-messages-chatgpt-swift-asyncsequence
    private func parse(_ line: String) -> String? {
        let components = line.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)
        guard components.count == 2, components[0] == "data" else { return nil }
        
        let message = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
        
        if message == "[DONE]" {
            return "\n"
        } else {
            let chunk = try? JSONDecoder().decode(OpenAIResponseChunk.self, from: message.data(using: .utf8)!)
            return chunk?.choices.first?.delta.content
        }
    }
    
    struct OpenAIRequestBody: Codable {
        var model = OpenAIConstants.openAIChatGPTModel
        // TODO: only supporting by gpt-4-1106-preview or gpt-3.5-turbo-1106, you can set response_format to { "type": "json_object" }
        // https://platform.openai.com/docs/guides/text-generation/json-mode
        // var response_format: OpenAIResponseFormat
        var messages: [OpenAIRequestMessage] = []
        var stream: Bool?
    }
    
    struct OpenAIRequestMessage: Codable {
        var role = OpenAIRequestMessageRole.system
        var content: String
    }
    
    enum OpenAIRequestMessageRole: String, Codable {
        case system = "system"
        case user = "user"
        case assistant = "assistant"
    }
    
    struct OpenAIResponseFormat: Codable {
        var type = "json_object"
    }
    
    struct OpenAIResponseBody: Codable {
        var id: String
        var object: String
        var created: Int
        var model: String
        var system_fingerprint: String?
        var choices: [OpenAIResponseChoice] = []
        var usage: OpenAIResponseUsage
    }
    
    struct OpenAIResponseChoice: Codable {
        var index: Int
        var message: OpenAIResponseMessage
        var finish_reason: String?
    }
    
    struct OpenAIResponseMessage: Codable {
        var role: OpenAIRequestMessageRole
        var content: String
    }
    
    struct OpenAIResponseUsage: Codable {
        var prompt_tokens: Int
        var completion_tokens: Int
        var total_tokens: Int
    }
    
    struct OpenAIResponseChunk: Codable {
        struct Choice: Codable {
            struct Delta: Codable {
                let role: String?
                let content: String?
            }
            let delta: Delta
        }
        let choices: [Choice]
    }
    
    enum OpenAIError: Error {
        case invalidRequestData
        case executeRequest
        case wrongResponseDataFormat
    }
}

let openAI = OpenAI()
