//
//  FontExtension.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 05/07/21.
//

import Foundation
import SwiftUI

extension Font {
    static func coconBold(sized: CGFloat) -> Font {
        Font.custom("cocon-bold.otf", size: sized)
    }
    
    static func sfProDisplayMedium(sized: CGFloat) -> Font {
        Font.custom("SFProDisplay-Medium.ttf", size: sized)
    }
    
    static func sfProDisplaySemiBold(sized: CGFloat) -> Font {
        Font.custom("SFProDisplay-Semibold.ttf", size: sized)
    }
    
    static func sfProDisplayRegular(sized: CGFloat) -> Font {
        Font.custom("SFProDisplay-Regular.ttf", size: sized)
    }
}
