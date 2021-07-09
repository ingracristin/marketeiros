//
//  TextViewExtension.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 17/06/21.
//

import SwiftUI

struct CellTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 20, weight: .medium, design: .default))
    }
}

struct CellSubTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 14, weight: .regular, design: .default))
            .foregroundColor(.gray)
    }
}

struct NavBarTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.coconBold(sized: 34))
            .foregroundColor(Color(UIColor.navBarTitleColor))
    }
}

extension Text {
    func cellTitle() -> some View {
        self.modifier(CellTitle())
    }
    
    func cellSubTitle() -> some View {
        self.modifier(CellSubTitle())
    }
    
    func navBarTitle() -> some View {
        self.modifier(NavBarTitle())
    }
}
