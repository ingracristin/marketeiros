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
                
            VStack(spacing: 20){
                
                HStack(alignment: .lastTextBaseline,spacing:0) {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(UIColor.appDarkGrey))
                    }
                    .isHidden(false)
                }.padding(.bottom,0)
                    
                HStack {
                    Text(NSLocalizedString("profile", comment: ""))
                        .navBarTitle()
                    Spacer()
                    
                }
                //.padding(.init(top: 0, leading: 20, bottom: 8, trailing: 0))
                
                HStack() {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("NavBarTitle"))
                        Text(user.email)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("UserProfileColor"))
                    }
                    Spacer()
                    Image("perfil")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.size.height * 0.0714, height: UIScreen.main.bounds.size.height * 0.0714)
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 5))
                        
                }
                Spacer().frame(height:UIScreen.main.bounds.size.height * 0.035)
                
                NavigationLink(
                    destination: UserDetailsView(user: $user),
                    label: {
                        HStack{
                            Text(NSLocalizedString("account", comment: ""))
                                .font(.title3)
                                
                            Spacer()
                            Image(systemName: "person")
                                .resizable()
                                .frame(width:UIScreen.main.bounds.size.height * 0.0246 ,height: UIScreen.main.bounds.size.height * 0.0246)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 25))
                        }
                    }).foregroundColor(Color("ProfileButtonsColor"))
                
               
                NavigationLink(
                    destination: HelpView(),
                    label: {
                        HStack{
                            Text(NSLocalizedString("help", comment: ""))
                                .font(.title3)
                            Spacer()
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width:UIScreen.main.bounds.size.height * 0.0246 ,height: UIScreen.main.bounds.size.height * 0.0246)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 25))
                        }
                    }).foregroundColor(Color("ProfileButtonsColor"))
                NavigationLink(
                    destination: AboutView(),
                    label: {
                        HStack{
                            Text(NSLocalizedString("about", comment: ""))
                                .font(.title3)
                            Spacer()
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .frame(width:UIScreen.main.bounds.size.height * 0.0246 ,height: UIScreen.main.bounds.size.height * 0.0246)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 25))
                        }
                    }).foregroundColor(Color("ProfileButtonsColor"))
                Spacer()
                //bell
                //globe
                //questionmark.circle
            }
            .padding(.horizontal, 20)
            .navigationBarHidden(true)
            .onAppear {
                if let currentUser = AuthService.current.user{
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView()
        }
        
    }
}
