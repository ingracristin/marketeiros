//
//  HelpView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 08/07/21.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("Suporte")
                    
                Spacer()
                Image(systemName: "chevron.forward")
            }.foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
            HStack{
                Text("Contate a gente")
                Spacer()
                Image(systemName: "chevron.forward")
            }.foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
           
            Spacer()
        }.padding()
        .navigationBarTitle("Sobre", displayMode: .inline)
        
        
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
