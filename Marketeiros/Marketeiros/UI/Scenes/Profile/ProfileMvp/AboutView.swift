//
//  AboutView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 07/07/21.
//

import SwiftUI

struct AboutView: View {
    
    var body: some View {
        ZStack(alignment:.bottom){
            Image("profileBg")
             .resizable()
             .scaledToFill()
            .ignoresSafeArea()
             .frame( height: UIScreen.main.bounds.size.height * 0.66, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack(spacing: 20){
                HStack{
                    Text(NSLocalizedString("terms", comment: ""))
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                HStack{
                    Text(NSLocalizedString("rate", comment: ""))
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                HStack{
                    Text("Website")
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                HStack{
                    Text(NSLocalizedString("version", comment: ""))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("1.0")
                        .foregroundColor(.gray)
                }
                Spacer()
                
                
            }.padding()
            .navigationBarTitle(NSLocalizedString("about", comment: ""), displayMode: .inline)
            .foregroundColor(Color("NavBarTitle"))
            
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        
        AboutView()
    }
}
