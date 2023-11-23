//
//  PreviewList1.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 21/11/23.
//

import SwiftUI

struct StaticScaleListHeightModifier: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory

    func body(content: Content) -> some View {
        let scaleFactor = estimateScaleFactor(for: sizeCategory)
        content
            .frame(height: scaleFactor)
    }
    
    func estimateScaleFactor(for sizeCategory: ContentSizeCategory) -> CGFloat {
        switch sizeCategory {
        case .extraSmall, .small, .medium, .large, .extraLarge, .extraExtraLarge, .extraExtraExtraLarge, .accessibilityMedium:
            return 200
        case .accessibilityLarge:
            return 260
        case .accessibilityExtraLarge:
            return 290
        case .accessibilityExtraExtraLarge:
            return 310
        case .accessibilityExtraExtraExtraLarge:
            return 330
        @unknown default:
            return 0
        }
    }
}

extension List {
    func staticScaleListHeightModifier() -> some View {
        self.modifier(StaticScaleListHeightModifier())
    }
}

struct PreviewList1: View {
    var body: some View {
        List {
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        .staticScaleListHeightModifier()
    }
}

#Preview {
    PreviewList1()
}
