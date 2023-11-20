//
//  CodeBlockHighlighter.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 19/11/23.
//

import SwiftUI
import Splash

struct CodeBlockHighlighter: View {
    var content: String?
    var actions: AnyView?
    
    @ScaledMetric(relativeTo: .body) var scaledFontSize: CGFloat = 14
    
    var body: some View {
        if content != nil {
            let highlightedCodeBlock = getHighlightedCodeBlock(content!)
            
            VStack(alignment: .trailing) {
                HStack {
                    Text(AttributedString(highlightedCodeBlock))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack (spacing: 24) {
                    actions
                }
            }
        }
    }
    
    func getHighlightedCodeBlock(_ content: String) -> NSAttributedString {
        // TODO: Do I neeed extract SyntaxHighlighter as static singleton instance?
        let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: .presentation(withFont: .init(size: scaledFontSize))))
        let highlightedCodeBlock = highlighter.highlight(content)
        
        return highlightedCodeBlock
    }
}

#Preview {
    CodeBlockHighlighter(content: "func hello(world: String) -> Int", actions: AnyView(VStack {
        Button(action: {}) {
            Label("Copy", systemImage: "doc.on.doc")
                .frame(width: 32, height: 32)
        }
        .labelStyle(.iconOnly)
        .buttonStyle(.bordered)
        .foregroundColor(.black.opacity(0.8))
        .buttonBorderShape(.circle)
        .frame(width: 38, height: 38)
    }))
}
