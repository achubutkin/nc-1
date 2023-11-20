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
        if let blocks {
            ForEach(blocks, id: \.hashValue) { block in
                switch block.type {
                case BlockTypes.code:
                    CodeBlockRenderer(block: block)
                case .text:
                    TextBlockRenderer(content: block.content)
                case .preview:
                    PreviewBlockRenderer(content: block.content)
                case .codeBlockAndPreview:
                    CodeBlockAndPreviewRenderer(content: block.content, previewComponent: block.previewComponent)
                }
            }
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
