//
//  ErrorMessage.swift
//  Marketeiros
//
//  Created by João Guilherme on 05/08/21.
//

import SwiftUI

struct ErrorMessage: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment:.center, spacing:15){
            Image("errorImage")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: UIScreen.main.bounds.size.width * 0.1466, height: UIScreen.main.bounds.size.height * 0.0527, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
            Text(NSLocalizedString("ops", comment: ""))
                .font(.callout)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("loadingTextColor"))
        }.frame(width: UIScreen.main.bounds.size.width * 0.552, height: UIScreen.main.bounds.size.height * 0.1711, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color("loadingsBgColor"))
        .cornerRadius(10)
        .shadow(radius: 6, x: 2, y: 4)
        //.opacity(self.isShowing ? 1 : 0)
    }
}

struct ErrorMessage_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessage(isShowing: .constant(true))
    }
}
