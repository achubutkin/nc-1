//
//  DetailsView.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 14/11/23.
//

import SwiftUI

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
                    
                    TextBlockRenderer(content: details.fullDescription)
                    
                    BlockTitle(content: "Details")
                    // Render all dynamics blocks
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

