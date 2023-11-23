//
//  PreviewButton1.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 16/11/23.
//

import SwiftUI

struct PreviewButton3: View {
    var body: some View {
        Button {
            // action code
        } label: {
            Label("Add Item", systemImage: "plus")
                .labelStyle(.automatic)
                .padding()
        }
    }
}

#Preview {
    PreviewButton3()
}
