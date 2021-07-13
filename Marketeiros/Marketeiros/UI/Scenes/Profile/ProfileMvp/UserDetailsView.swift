//
//  UserDetailsView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 07/07/21.
//

import SwiftUI

struct UserDetailsView: View {
    @State var boardName = ""
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Spacer()
                ZStack{
                   
                    Image("bolinha")
                        .resizable()
                        .frame(width: 90, height: 90)
                    
                    Image("camera")
                        .frame(width: 100, height: 100, alignment: .bottomTrailing)
                        .padding(.horizontal,40)
                        
                }
                Spacer()
            }
            
            Text(NSLocalizedString("account", comment: ""))
                .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                .foregroundColor(Color("NavBarTitle"))
                .padding()
            HStack{
                HStack{
                    Text(NSLocalizedString("name", comment: ""))
                        .foregroundColor(Color("NavBarTitle"))
                }.padding()
                Spacer()
                HStack{
                    ZStack(alignment:.trailing){
                        TextField("", text: $boardName)
                            .padding()
                            .frame(width: 280, height: 50)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                        
                    }
                }
            }
            HStack{
                HStack{
                    Text(NSLocalizedString("user", comment: ""))
                        .foregroundColor(Color("NavBarTitle"))
                }.padding()
                Spacer()
                HStack{
                    ZStack(alignment:.trailing){
                        TextField("", text: $boardName)
                            .padding()
                            .frame(width: 280, height: 50)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                        
                    }
                }
            }.foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
            HStack{
                HStack{
                    Text("E-mail")
                        .foregroundColor(Color("NavBarTitle"))
                }.padding()
                Spacer()
                HStack{
                    ZStack(alignment:.trailing){
                        TextField("E-mail do convidado", text: $boardName)
                            .padding()
                            .frame(width: 280, height: 50)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                        
                    }
                }
            }.foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
            
           Spacer()
        }.padding()
        .navigationBarTitle(NSLocalizedString("account", comment: ""),displayMode: .inline )
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView()
    }
}
