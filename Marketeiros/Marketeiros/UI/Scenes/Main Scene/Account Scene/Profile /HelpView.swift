//
//  HelpView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 08/07/21.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.presentationMode) var presentationMode
    let urlSup = URL(string:"https://planiapp.wixsite.com/plani")
    
    var body: some View {
        ZStack(alignment:.bottom){
            Image("profileBg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame( height: UIScreen.main.bounds.size.height * 0.66, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack(spacing: 20){
                CustomNavBar(title: NSLocalizedString("help", comment: ""), backButtonAction: {
                    presentationMode.wrappedValue.dismiss()
                }, trailing: {
                    EmptyView()
                })
                Button(action: {
                    UIApplication.shared.open(urlSup!)
                }){
                    HStack{
                        Text(NSLocalizedString("sup", comment: ""))
                            .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                        
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .foregroundColor(Color("AppLightBlue"))
                    }.foregroundColor(Color("NavBarTitle"))
                }
                
                Button(action: {
                    UIApplication.shared.open(urlSup!)
                }){
                    HStack{
                        Text(NSLocalizedString("contact", comment: ""))
                            .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .foregroundColor(Color("AppLightBlue"))
                    }.foregroundColor(Color("NavBarTitle"))
                }
                Spacer()
            }
            .navigationBarHidden(false)
            .padding()
            .navigationBarTitle(NSLocalizedString("help", comment: ""), displayMode: .inline)
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
