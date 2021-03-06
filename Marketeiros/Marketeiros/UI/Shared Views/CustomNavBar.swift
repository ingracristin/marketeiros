//
//  CustomNavBar.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 09/09/21.
//

import SwiftUI

struct CustomNavBar<Placeholder: View>: View {
    var title: String
    var trailing: Placeholder
    var backButtonAction: () -> ()
    
    init(title: String, backButtonAction:  @escaping () -> (), @ViewBuilder trailing: () -> Placeholder) {
        self.title = title
        self.backButtonAction = backButtonAction
        self.trailing = trailing()
    }
    
    var body: some View {
        ZStack {
            HStack{
                Spacer()
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("textColorCreatePost"))
                Spacer()
            }
            
            HStack {
                Button(action: {
                    backButtonAction()
                }, label: {
                    HStack(spacing:3) {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: 24, weight: .semibold))
                        Text("Back")
                            .fontWeight(.regular)
                    }.foregroundColor(.blue)
                })
                Spacer()
                trailing
            }
        }
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBar(title: "aaa", backButtonAction: {}, trailing: {
                Button(action: {}, label: {
                    Text("aa")
                })
            })
            Spacer()
        }
    }
}
