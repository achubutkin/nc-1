//
//  PreviewButton1.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 18/11/23.
//

import SwiftUI

struct PreviewButton1: View {
    var body: some View {
        Button(action: {
            // action
        }) {
            Text("Button")
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
        }

    }
}

#Preview {
    PreviewButton1()
}
