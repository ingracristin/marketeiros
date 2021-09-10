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
    
    init(title: String, @ViewBuilder trailing: () -> Placeholder) {
        self.title = title
        self.trailing = trailing()
    }
    
    var body: some View {
        ZStack {
            HStack{
                Spacer()
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Spacer()
            }
            
            HStack {
                Button(action: {
                    
                }, label: {
                    HStack(spacing:2) {
                        Image(systemName: "chevron.left")
                            .font(Font.system(size: 24, weight: .regular))
                        Text("Back")
                            .fontWeight(.regular)
                    }.foregroundColor(.blue)
                })
                Spacer()
                trailing
            }.padding()
        }
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBar(title: "aaa", trailing: {
                Button(action: {}, label: {
                    Text("aa")
                })
            })
            Spacer()
        }
    }
}
