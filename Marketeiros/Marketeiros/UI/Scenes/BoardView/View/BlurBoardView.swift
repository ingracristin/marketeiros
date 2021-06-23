//
//  BlurBoardView.swift
//  Marketeiros
//
//  Created by João Guilherme on 18/06/21.
//

import SwiftUI

struct BlurBoardView : UIViewRepresentable {
    var style : UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
            return view
        }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    
    }
}
