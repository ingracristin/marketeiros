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
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            Image("HeaderPerfil")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height * 0.2906)
                .ignoresSafeArea()
            VStack() {
                HStack {
                    Text(NSLocalizedString("profile", comment: ""))
                        .navBarTitle()
                    Spacer()
                }
                .padding(.init(top: 30, leading: 20, bottom: 10, trailing: 0))
                
                HStack() {
                    VStack(alignment: .leading) {
                        Text("Ingra Cristina")
                            .font(.custom("SF Pro Display", size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("NavBarTitle"))
                        Text("@ingracristic")
                            .font(.custom("SF Pro Display", size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("UserProfileColor"))
                    }.padding(.horizontal,20)
                    Spacer()
                    Image("bolinha")
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
                    destination: NotificationsDetailsView(),
                    label: {
                        HStack{
                            Text(NSLocalizedString("notifi", comment: ""))
                                .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                            Spacer()
                            Image(systemName: "bell")
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
            }.padding()
            .navigationBarHidden(true)
            
            
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
