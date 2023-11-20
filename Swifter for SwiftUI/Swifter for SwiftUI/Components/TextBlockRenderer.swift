//
//  TextBlockRenderer.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 16/11/23.
//

import SwiftUI

struct TextBlockRenderer: View {
    var content: String = ""
    
    var body: some View {
        let attributeString = try! AttributedString(markdown: content)
        BlockParagraph(attributeString)
    }
}

#Preview {
    TextBlockRenderer(content: "Content within _markdown_ formatter.")
}
