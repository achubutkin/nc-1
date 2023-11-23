//
//  PreviewList3.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 21/11/23.
//

import SwiftUI

struct PreviewList3: View {
    @State var paths: [String] = []
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Item 1", value: "")
                NavigationLink("Item 2", value: "")
                NavigationLink("Item 3", value: "")
            }
            .staticScaleListHeightModifier()
        }
    }
}

#Preview {
    PreviewList3()
}
