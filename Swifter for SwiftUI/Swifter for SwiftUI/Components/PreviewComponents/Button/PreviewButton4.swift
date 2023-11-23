//
//  PreviewButton1.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 16/11/23.
//

import SwiftUI

struct PreviewButton4: View {
    var body: some View {
        Button {
            // action code
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "chevron.backward")
                    .imageScale(.large)
                    .fontWeight(.semibold)
                Text("Back")
            }
            .padding()
        }
    }
}

#Preview {
    PreviewButton4()
}
