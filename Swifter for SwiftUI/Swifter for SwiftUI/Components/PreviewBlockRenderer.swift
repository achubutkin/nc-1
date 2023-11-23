//
//  PreviewBlockRenderer.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 16/11/23.
//

import SwiftUI

// TODO: preview style as tooltip in XCode code editor

struct PreviewBlockRenderer: View {
    var content: String = ""
    
    var body: some View {
        if !content.isEmpty {
            ZStack {
                let previewComponent = PreviewComponents[content]
                if previewComponent != nil {
                    previewComponent
                }
                else {
                    fatalError("Not found component!")
                }
            }
            .padding()
            .background(.gray.opacity(0.1))
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
        }
    }
}

#Preview {
    PreviewBlockRenderer(content: "PreviewButton2")
}
