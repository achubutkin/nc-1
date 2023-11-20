//
//  DetailsView.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 14/11/23.
//

import SwiftUI

struct BlockTitle: View {
    var content: String
    
    var body: some View {
        HStack {
            Text(content)
                .font(.system(size: 16, weight: .bold))
        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 10, trailing: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

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
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension BlockParagraph {
    public init(_ attributedContent: AttributedString) {
        self.attributedContent = attributedContent
    }
}

struct DetailsView: View {
    var component: Component
    var componentDetails: ComponentDetails?

    var body: some View {
        NavigationStack {
            ScrollView {
                if let details = componentDetails {
                    BlockTitle(content: details.name)
                        .fontDesign(.monospaced)
                    BlockParagraph(details.shortDescription)
                        .fontDesign(.monospaced)
                    BlockParagraph(details.fullDescription)
                    BlocksRenderer(blocks: details.blocks)
                }
            }
            .navigationTitle(component.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DetailsView(component: Component(id: 1, name: "GroupBox"), componentDetails: ComponentDetails(id: 1, name: "GroupBox", shortDescription: "A stylized view, with an optional label, that visually collects a logical grouping of content.", fullDescription: "Use a group box when you want to visually distinguish a portion of your user interface with an optional title for the boxed content.", blocks: []))
}

