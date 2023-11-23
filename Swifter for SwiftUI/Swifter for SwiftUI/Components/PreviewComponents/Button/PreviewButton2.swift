//
//  PreviewButton1.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 16/11/23.
//

import SwiftUI

struct PreviewButton2: View {
    var body: some View {
        Button {
            // action code
        } label: {
            Text("Button")
                .padding(.horizontal)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: 400)
        .buttonStyle(.borderedProminent)
        .tint(.orange)
    }
}

#Preview {
    PreviewButton2()
}
