//
//  PreviewButton1.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 16/11/23.
//

import SwiftUI

struct PreviewButton11: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Button {
                    // action code
                } label: {
                    Label("Add Item", systemImage: "plus")
                        .imageScale(.large)
                        .labelStyle(.iconOnly)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                
                Button {
                    // action code
                } label: {
                    Label("Add Item", systemImage: "plus")
                        .labelStyle(.automatic)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
            }
            
            HStack(spacing: 16) {
                Button {
                    // action code
                } label: {
                    Text("Button")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Button {
                    // action code
                } label: {
                    Text("Button")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            
            HStack(spacing: 16) {
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
                Spacer()
                Button {
                    // action code
                } label: {
                    Label("Add Item", systemImage: "plus")
                        .labelStyle(.iconOnly)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    PreviewButton11()
}
