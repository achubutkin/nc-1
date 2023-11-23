//
//  CodeBlockHighlighter.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 19/11/23.
//

import SwiftUI
import Splash

struct CodeBlockHighlighter: View {
    @Environment(\.colorScheme) var colorScheme
    
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
        var theme = Theme.presentation(withFont: .init(size: scaledFontSize))
        theme.plainTextColor = (colorScheme == .light ? .black : .white)
        
        let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: theme))
        let highlightedCodeBlock = highlighter.highlight(content)
        
        return highlightedCodeBlock
    }
}

#Preview {
    CodeBlockHighlighter(content: "func hello(world: String) -> Int")
}
