//
//  UserDetailsView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 07/07/21.
//

import SwiftUI

struct UserDetailsView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @State var username = ""
    @State var name = ""
    @State var email = ""
    @Binding var user: UserProfile
    
    var body: some View {
        VStack(alignment:.leading, spacing: 16){
            HStack{
                Spacer()
                ZStack(alignment: .bottomTrailing){
                    Image("perfil")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.height * 0.1231, height: UIScreen.main.bounds.height * 0.1231)
//                        .overlay(Image(systemName: "camera")
//                                    .foregroundColor(Color("cameraColor")), alignment: .bottomTrailing)
                        //.frame(width: 100, height: 100)
                        //.padding(.horizontal,40)
                        //.foregroundColor(Color("cameraColor"))
                }
                Spacer()
            }
            
            Text(NSLocalizedString("accountData", comment: ""))
                .fontWeight(.semibold)
                .font(.title2)
                .foregroundColor(Color("NavBarTitle"))
               
            HStack{
                HStack{
                    Text(NSLocalizedString("name", comment: ""))
                        .foregroundColor(Color("NavBarTitle"))
                        .font(.body)
                }
                Spacer()
                HStack{
                    ZStack(alignment:.trailing){
                        TextField(user.name, text: $name)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.68, height: UIScreen.main.bounds.height * 0.0517)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                    }
                }
            }
            HStack{
                HStack{
                    Text(NSLocalizedString("user", comment: ""))
                        .foregroundColor(Color("NavBarTitle"))
                        .font(.body)
                }
                Spacer()
                HStack{
                    ZStack(alignment:.trailing){
                        TextField(user.username, text: $username)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.68, height: UIScreen.main.bounds.height * 0.0517)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                    }
                }
            }.foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
            HStack{
                HStack{
                    Text("E-mail")
                        .foregroundColor(Color("NavBarTitle"))
                        .font(.body)
                }
                Spacer()
                HStack{
                    ZStack(alignment:.trailing){
                        Text(user.email)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.68, height: UIScreen.main.bounds.height * 0.0615)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                    }
                }
            }.foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
            
           Spacer()
//            HStack(){
//                Spacer()
//                Button(action: {
//                    authenticationViewModel.signOut()
//                }, label: {
//                    Text(NSLocalizedString("deleteAcc", comment: ""))
//                        .foregroundColor(.red)
//                        .font(.body)
//
//                })
//                Spacer()
//            }
        }.padding(.init(top: 0, leading: 20, bottom: 10, trailing: 20))
        .navigationBarTitle(NSLocalizedString("account", comment: ""),displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            if !username.isEmpty {
                user.username = username
            }
            
            if !name.isEmpty {
                user.name = name
            }
            UserProfileRepository.current.update(user: user) { _ in
                
            }
        }, label: {
            Text(NSLocalizedString("save", comment: ""))
        }))
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: .constant(.init(uid: "", email: "", name: "", username: "")))
    }
}
