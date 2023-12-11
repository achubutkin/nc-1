//
//  BlocksRenderer.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 16/11/23.
//

import SwiftUI

struct BlocksRenderer: View {
    var blocks: [Block]? = []
    
    var body: some View {
        ForEach(blocks ?? [], id: \.hashValue) { block in
            renderBlock(block)
        }
    }
    
    @ViewBuilder
    private func renderBlock(_ block: Block) -> some View {
        switch block.type {
        case .code:
            CodeBlockAndAICodeGeneratorRenderer(content: block.content, aiCodeGeneratorPrompt: block.aiCodeGeneratorPrompt)
                .accessibilityAddTraits([.isSummaryElement])
                .accessibilityLabel("Code block with AI Chat GPT Code Generator. Tap to Generate Code button to generate relevant example code.")
        case .text:
            TextBlockRenderer(content: block.content)
        case .preview:
            PreviewBlockRenderer(content: block.content)
        case .codeBlockAndPreview:
            CodeBlockAndPreviewRenderer(content: block.content, previewComponent: block.previewComponent)
        }
    }
}

#Preview {
    BlocksRenderer(blocks: [
        Block(type: BlockTypes.code, content: "func hello(world: String) -> Int"),
        Block(type: BlockTypes.text, content: "func hello(world: String) -> Void"),
        Block(type: BlockTypes.codeBlockAndPreview, content: "func hello(world: String) -> Void", previewComponent: "PreviewButton2")
    ])
}
