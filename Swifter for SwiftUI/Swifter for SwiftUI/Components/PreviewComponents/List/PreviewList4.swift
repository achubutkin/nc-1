//
//  PreviewList4.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 21/11/23.
//

import SwiftUI

struct PreviewList4: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    
                } label: {
                    HStack {
                        Text("Item 1")
                        Spacer()
                        Text("TOP")
                    }
                }
                NavigationLink("Item 2", value: "")
                NavigationLink("Item 3", value: "")
            }
            .staticScaleListHeightModifier()
            .listStyle(.plain)
        }
    }
}

#Preview {
    PreviewList4()
}
