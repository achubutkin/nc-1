//
//  CodeBlockAndPreviewRenderer.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 19/11/23.
//

import SwiftUI

struct CodeBlockAndPreviewRenderer: View {
    @ScaledMetric(relativeTo: .body) var scaledButtonSize: CGFloat = 22
    
    var content: String?
    var previewComponent: String?
    
    @State private var isCopied = false
    
    var body: some View {
        VStack (spacing: 0) {
            if previewComponent != nil && !previewComponent!.isEmpty {
                ZStack {
                    Color.gray.opacity(0.16)
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
                            .frame(width: scaledButtonSize, height: scaledButtonSize)
                    }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.bordered)
                        .foregroundColor(.gray)
                        .buttonBorderShape(.circle)
                        .contentTransition(.symbolEffect(.replace))
                        .frame(width: scaledButtonSize, height: scaledButtonSize)
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
}

#Preview {
    CodeBlockAndPreviewRenderer(content: "func hello(world: String) -> Void", previewComponent: "PreviewButton2")
}
