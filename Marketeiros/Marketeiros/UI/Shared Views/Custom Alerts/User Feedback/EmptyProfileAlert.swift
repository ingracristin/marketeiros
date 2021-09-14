//
//  EmptyProfileAlert.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 14/09/21.
//

import SwiftUI

// Adicione seu feed do Instagram editando seu Perfil clicando no @username e/ou planeje um post clicando em "Novo”
struct EmptyProfileAlert: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment:.center, spacing:15){
            Image("errorImage")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: UIScreen.main.bounds.size.width * 0.1466, height: UIScreen.main.bounds.size.height * 0.0527, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
            Text(NSLocalizedString("emptyProfile", comment: ""))
                .font(.callout)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("loadingTextColor"))
        }
        .cornerRadius(10)
        .padding()
        //.frame(width: UIScreen.main.bounds.size.width * 0.552, height: UIScreen.main.bounds.size.height * 0.1711, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color("loadingsBgColor"))
        .padding(.horizontal, 50)
        .shadow(radius: 6, x: 2, y: 4)
        //.opacity(self.isShowing ? 1 : 0)
    }
}

struct EmptyProfileAlert_Previews: PreviewProvider {
    static var previews: some View {
        EmptyProfileAlert(isShowing: .constant(true))
    }
}
