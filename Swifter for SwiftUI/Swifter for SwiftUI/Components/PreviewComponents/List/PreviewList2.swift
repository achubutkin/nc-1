//
//  PreviewList2.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 21/11/23.
//

import SwiftUI

struct PreviewList2: View {
    var body: some View {
        VStack {
            List {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
            .staticScaleListHeightModifier()
            .listStyle(.plain)
        }
    }
}

#Preview {
    PreviewList2()
}
