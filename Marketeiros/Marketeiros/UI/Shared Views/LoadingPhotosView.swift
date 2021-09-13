//
//  LoadingPhotosView.swift
//  Marketeiros
//
//  Created by João Guilherme on 05/08/21.
//

import SwiftUI

struct LoadingPhotosView: View {
    @Binding var isShowing: Bool
    @State private var isAnimating = false
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 0.5)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack(alignment:.center, spacing:15){
            Image("loadingStar1")
                .resizable()
                .frame(width: UIScreen.main.bounds.size.width * 0.1126, height: UIScreen.main.bounds.size.height * 0.0527, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text(NSLocalizedString("loadingPhotos", comment: ""))
                .font(.callout)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("loadingTextColor"))
        }.frame(width: UIScreen.main.bounds.size.width * 0.552, height: UIScreen.main.bounds.size.height * 0.1711, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color("loadingsBgColor"))
        .cornerRadius(10)
        .shadow(radius: 6, x: 2, y: 4)
        //+.opacity(self.isShowing ? 1 : 0)
    }
}


struct LoadingPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingPhotosView(isShowing: .constant(true))
    }
}
