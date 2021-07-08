//
//  AboutView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 07/07/21.
//

import SwiftUI

struct AboutView: View {
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("Termos e condicões")
                Spacer()
                Image(systemName: "chevron.forward")
            }
            HStack{
                Text("Classificar app na App Store")
                Spacer()
                Image(systemName: "chevron.forward")
            }
            HStack{
                Text("Website")
                Spacer()
                Image(systemName: "chevron.forward")
            }
            HStack{
                Text("Website")
                    .foregroundColor(.gray)
                Spacer()
                Text("1.0")
                    .foregroundColor(.gray)
            }
            Spacer()
        }.padding()
        .navigationBarTitle("Sobre", displayMode: .inline)
        .foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
        
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        
        AboutView()
    }
}
