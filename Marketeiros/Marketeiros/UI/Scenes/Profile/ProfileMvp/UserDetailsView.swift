//
//  UserDetailsView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 07/07/21.
//

import SwiftUI

struct UserDetailsView: View {
    @State var username = ""
    @State var name = ""
    @State var email = ""
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State var user = UserProfile(uid: "", email: "email@example.com", name: "Name", username: "Username")
    
    var body: some View {
        VStack(alignment:.leading, spacing: 16){
            HStack{
                Spacer()
                ZStack(alignment: .bottomTrailing){
                   
                    Image("perfil")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.height * 0.1231, height: UIScreen.main.bounds.height * 0.1231)
                        .overlay(Image(systemName: "camera")
                                    .foregroundColor(Color("cameraColor")), alignment: .bottomTrailing)
                    
                    
                        //.frame(width: 100, height: 100)
                        //.padding(.horizontal,40)
                        //.foregroundColor(Color("cameraColor"))
                        
                    
                    
                }
                Spacer()
            }
            
            Text(NSLocalizedString("accountData", comment: ""))
                .bold()
                .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                .foregroundColor(Color("NavBarTitle"))
               
            HStack{
                HStack{
                    Text(NSLocalizedString("name", comment: ""))
                        .foregroundColor(Color("NavBarTitle"))
                        .font(.custom("SF Pro Display", size: 20))
                }
                Spacer()
                HStack{
                    ZStack(alignment:.trailing){
                        TextField(user.name, text: $name)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.704, height: UIScreen.main.bounds.height * 0.0517)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                        
                    }
                }
            }
            HStack{
                HStack{
                    Text(NSLocalizedString("user", comment: ""))
                        .foregroundColor(Color("NavBarTitle"))
                        .font(.custom("SF Pro Display", size: 20))
                }
                Spacer()
                HStack{
                    ZStack(alignment:.trailing){
                        TextField(user.username, text: $username)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.704, height: UIScreen.main.bounds.height * 0.0517)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                        
                    }
                }
            }.foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
            HStack{
                HStack{
                    Text("E-mail")
                        .foregroundColor(Color("NavBarTitle"))
                        .font(.custom("SF Pro Display", size: 20))
                }
                Spacer()
                HStack{
                    ZStack(alignment:.trailing){
                        TextField(user.email, text: $email)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.704, height: UIScreen.main.bounds.height * 0.0615)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                        
                    }
                }
            }.foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
            
           Spacer()
            HStack(){
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Excluir conta")
                        .foregroundColor(.red)
                        .font(.custom("SF Pro Display", size: 20))
                    
                })
                Spacer()
            }
            
            
            
        }.padding(.horizontal, 20)
        .navigationBarTitle(NSLocalizedString("account", comment: ""),displayMode: .inline )
        .onAppear {
            let currentUser = AuthService.current.user!
            UserProfileRepository.current.getUserWith(uid: currentUser.uid) { result in
                switch result {
                case .failure(_):
                    print()
                case .success(let userProfile):
                    self.user = userProfile
                }
            }
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView()
    }
}
