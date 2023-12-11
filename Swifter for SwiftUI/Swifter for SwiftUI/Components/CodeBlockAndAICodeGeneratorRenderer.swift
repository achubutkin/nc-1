//
//  CodeBlockAndPreviewRenderer.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 19/11/23.
//

import SwiftUI

struct CodeBlockAndAICodeGeneratorRenderer: View {
    @Environment(\.colorScheme) var colorScheme
    @ScaledMetric(relativeTo: .body) var scaledButtonSize: CGFloat = 22
    
    @State var content: String?
    var aiCodeGeneratorPrompt: String?
    
    @State private var isGeneratingCodeBlock: Bool = false
    @State private var isGenerationCodeBlockHasError: Bool = false
    @State private var isCopied = false
    
    private let promptAICodeGenerationMessage = "The \(OpenAIConstants.openAIChatGPTModel.uppercased()) thinks about generating a new block of code..."
    private let promptAICodeGenerationWelcomeMessage = "Generate more examples within the \(OpenAIConstants.openAIChatGPTModel.uppercased()) model code generator."
    
    var body: some View {
        if aiCodeGeneratorPrompt != nil && !aiCodeGeneratorPrompt!.isEmpty {
            HStack {
                BlockTitle(content: "Chat GPT Code Generator")
                Spacer()
            }
            HStack {
                BlockParagraph(promptAICodeGenerationWelcomeMessage)
            }
        }
        
        VStack (spacing: 0) {
            ZStack {
                CodeBlockHighlighter(content: content, actions: AnyView(
                    HStack (spacing: 24) {
                        if isGeneratingCodeBlock {
                            Text(promptAICodeGenerationMessage)
                                .font(.footnote)
                                .monospaced()
                            Spacer()
                        }
                        
                        if aiCodeGeneratorPrompt != nil && !aiCodeGeneratorPrompt!.isEmpty {
                            Button(action: generateCodeBlock) {
                                var openAILogoIcon = Image("OpenAILogoIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                    .frame(width: scaledButtonSize, height: scaledButtonSize)
                                
                                if colorScheme == .dark {
                                    openAILogoIcon.colorInvert()
                                }
                                else {
                                    openAILogoIcon
                                }
                            }
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.circle)
                            .contentTransition(.symbolEffect(.replace))
                            .frame(width: scaledButtonSize, height: scaledButtonSize)
                            .tint(colorScheme == .dark ? Color.white : Color.black)
                            .accessibilityLabel("Generate code with Chat GPT model.")
                        }
                        
                        Button(action: copyCodeBlock) {
                            Label("Copy", systemImage: isCopied ? "checkmark" : "doc.on.doc")
                                .frame(width: scaledButtonSize, height: scaledButtonSize)
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.bordered)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .buttonBorderShape(.circle)
                        .contentTransition(.symbolEffect(.replace))
                        .frame(width: scaledButtonSize, height: scaledButtonSize)
                        .accessibilityLabel("Copy. Button. Press copy there then paste on your Mac.")
                    }
                ))
            }
            .padding()
            .background(Color.gray.opacity(0.1))
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    func copyCodeBlock() -> Void {
        if isCopied {
            return
        }
        isCopied.toggle()
        UIPasteboard.general.string = content
        Task {
            sleep(1)
            isCopied.toggle()
        }
    }
    
    func generateCodeBlock() -> Void {
        if openAI.isRequestInProgress {
            return
        }
        
        Task {
            isGenerationCodeBlockHasError = false
            
            withAnimation (.easeInOut(duration: 0.3)) {
                isGeneratingCodeBlock = true
            }
            
            sleep(2)
            
            let message = "Make example of making Button component of Swift UI."
            var needClearCodeBlockField = true
            
            do {
                try await openAI.fetchChatCompletion(message: message, receiveHandler: { message in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        if needClearCodeBlockField {
                            needClearCodeBlockField = false
                            content = "//\n// Generated by \(OpenAIConstants.openAIChatGPTModel.uppercased())\n//\n\n"
                            isGeneratingCodeBlock = false
                        }
                        content = content! + message
                    }
                })
            }
            catch {
                isGeneratingCodeBlock = false
                isGenerationCodeBlockHasError = true
            }
        }
    }
}

#Preview {
    CodeBlockAndAICodeGeneratorRenderer(content: "func hello(world: String) -> Void", aiCodeGeneratorPrompt: "Make example of Button component.")
}
