//
//  BlockTitle.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 23/11/23.
//
import SwiftUI

struct BlockTitle: View {
    var content: String
    
    var body: some View {
        HStack {
            Text(content)
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 10, trailing: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
