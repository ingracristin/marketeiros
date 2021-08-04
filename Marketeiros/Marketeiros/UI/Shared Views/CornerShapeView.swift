//
//  CornerShapeView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 03/08/21.
//

import SwiftUI

struct CornerShapeView: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CornerShapeView_Previews: PreviewProvider {
    static var previews: some View {
        CornerShapeView(corners: [.bottomLeft,.bottomRight], radius: 20)
    }
}
