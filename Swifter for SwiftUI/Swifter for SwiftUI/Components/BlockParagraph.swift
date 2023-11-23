//
//  BlockParagraph.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 23/11/23.
//
import SwiftUI

struct BlockParagraph: View {
    var content: (any StringProtocol)?
    var attributedContent: AttributedString?
    
    public init<S>(_ content: S) where S : StringProtocol {
        self.content = content
    }
    
    var body: some View {
        HStack {
            if let content {
                Text(content)
            }
            else if let attributedContent {
                Text(attributedContent)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension BlockParagraph {
    public init(_ attributedContent: AttributedString) {
        self.attributedContent = attributedContent
    }
}
