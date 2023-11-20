//
//  CodeBlockAndPreviewRenderer.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 19/11/23.
//

import SwiftUI

struct CodeBlockAndPreviewRenderer: View {
    var content: String?
    var previewComponent: String?
    @State var isCopied = false
    
    var body: some View {
        ScrollView {
            VStack (spacing: 0) {
                ZStack {
                    Color.gray.opacity(0.16)
                    if previewComponent != nil && !previewComponent!.isEmpty {
                        ZStack {
                            let previewComponent = PreviewComponents[previewComponent!]
                            if previewComponent != nil {
                                previewComponent
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                }
                
                ZStack {
                    CodeBlockHighlighter(content: content, actions: AnyView(
                        Button(action: copyCodeBlock) {
                            Label("Copy", systemImage: isCopied ? "checkmark" : "doc.on.doc")
                                .frame(width: 32, height: 32)
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.bordered)
                        .foregroundColor(.black.opacity(0.8))
                        .buttonBorderShape(.circle)
                        .contentTransition(.symbolEffect(.replace))
                        .frame(width: 38, height: 38)
                    ))
                }
                .padding()
                .background(Color.gray.opacity(0.1))
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding()
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
}

#Preview {
    CodeBlockAndPreviewRenderer(content: "func hello(world: String) -> Void", previewComponent: "PreviewButton2")
}
