//
//  ProfileMvpView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 07/07/21.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isShow = false
    @State private var showingPopover = false
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State var user = UserProfile(uid: "", email: "email@example.com", name: "Name", username: "Username")
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            Image("HeaderPerfil")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height * 0.2906)
                .ignoresSafeArea()
                .shadow(radius: 6)
                
            VStack() {
                
                HStack(alignment: .lastTextBaseline,spacing:0) {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .frame(height: 40)
                    }
                    .isHidden(true)
                }.padding(.bottom,0)
                    
                HStack {
                    Text(NSLocalizedString("profile", comment: ""))
                        .navBarTitle()
                    Spacer()
                    
                }
                .padding(.bottom,8)
                
                HStack() {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.custom("SF Pro Display", size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("NavBarTitle"))
                        Text(user.email)
                            .font(.custom("SF Pro Display", size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("UserProfileColor"))
                    }.padding(.horizontal,20)
                    Spacer()
                    Image("perfil")
                        .resizable()
                        .frame(width: 58, height: 58)
                        .padding()
                }
                Spacer().frame(height:UIScreen.main.bounds.size.height * 0.035)
                
                NavigationLink(
                    destination: UserDetailsView(),
                    label: {
                        HStack{
                            Text(NSLocalizedString("account", comment: ""))
                                .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                                
                            Spacer()
                            Image(systemName: "person")
                        }.padding()
                    }).foregroundColor(Color("ProfileButtonsColor"))
                
               
                NavigationLink(
                    destination: HelpView(),
                    label: {
                        HStack{
                            Text(NSLocalizedString("help", comment: ""))
                                .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                            Spacer()
                            Image(systemName: "globe")
                        }.padding()
                    }).foregroundColor(Color("ProfileButtonsColor"))
                NavigationLink(
                    destination: AboutView(),
                    label: {
                        HStack{
                            Text(NSLocalizedString("about", comment: ""))
                                .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                            Spacer()
                            Image(systemName: "questionmark.circle")
                        }.padding()
                    }).foregroundColor(Color("ProfileButtonsColor"))
                Spacer()
                //bell
                //globe
                //questionmark.circle
            }
            .padding()
            .navigationBarHidden(true)
            .onAppear {
                /*let currentUser = AuthService.current.user!
                UserProfileRepository.current.getUserWith(uid: currentUser.uid) { result in
                    switch result {
                    case .failure(_):
                        print()
                    case .success(let userProfile):
                        self.user = userProfile
                    }
                }*/
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView()
        }
        
    }
}
