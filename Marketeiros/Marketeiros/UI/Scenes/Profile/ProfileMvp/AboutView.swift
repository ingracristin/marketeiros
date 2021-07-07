//
//  AboutView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 07/07/21.
//

import SwiftUI

struct AboutView: View {
    @State var boardName = ""
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                HStack{
                    Text("nome")
                }.padding()
                HStack{
                    ZStack(alignment:.trailing){
                        TextField("E-mail do convidado", text: $boardName)
                            .padding()
                            .frame(height: 60)
                            .background(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                            .cornerRadius(8)
                        
                    }
                }
            }
           
        }.padding()
        .navigationBarTitle("hm",displayMode: .inline )
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        
        AboutView()
    }
}
