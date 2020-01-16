//
//  Watermark.swift
//  SnowSeeker
//
//  Created by Chris on 16/01/2020.
//  Copyright © 2020 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.5))
                .accessibility(hidden: true)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}
