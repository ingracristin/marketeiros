//
//  ErrorMissingInformation.swift
//  Marketeiros
//
//  Created by João Guilherme on 11/08/21.
//

import SwiftUI

struct ErrorMissingInformation<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack(alignment:.center){
            self.content()
                .disabled(self.isShowing)
                .blur(radius: self.isShowing ? 3 : 0)
            
            VStack(alignment:.center, spacing:15){
                Image("errorImage")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.size.width * 0.1126, height: UIScreen.main.bounds.size.height * 0.0527, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                
                Text(NSLocalizedString("missing", comment: ""))
                    .font(.callout)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("loadingTextColor"))
            }.frame(width: UIScreen.main.bounds.size.width * 0.552, height: UIScreen.main.bounds.size.height * 0.1711, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color("loadingsBgColor"))
            .cornerRadius(10)
            .shadow(radius: 6, x: 2, y: 4)
            .opacity(self.isShowing ? 1 : 0)
            
        }
    }
}

struct ErrorMissingInformation_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMissingInformation(isShowing: .constant(true)) {
            Text("")
        }
    }
}
