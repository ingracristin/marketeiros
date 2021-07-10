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
                    Text("Perfil")
                        .navBarTitle()
                    Spacer()
                }
                .padding(.init(top: 30, leading: 0, bottom: 10, trailing: 0))
                
                HStack() {
                    VStack(alignment: .leading) {
                        Text("Ingra Cristina")
                            .font(.custom("SF Pro Display", size: 20))
                            .fontWeight(.semibold)
                        Text("@ingracristic")
                            .font(.custom("SF Pro Display", size: 16))
                            .fontWeight(.semibold)
                    }.padding()
                    Spacer()
                    Image("bolinha")
                        .padding()
                }
                Spacer().frame(height:UIScreen.main.bounds.size.height * 0.035)
                
                NavigationLink(
                    destination: UserDetailsView(),
                    label: {
                        HStack{
                            Text("Conta")
                                .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                                
                            Spacer()
                            Image(systemName: "person")
                        }.padding()
                    }).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                
                NavigationLink(
                    destination: NotificationsDetailsView(),
                    label: {
                        HStack{
                            Text("Notificações")
                                .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                            Spacer()
                            Image(systemName: "bell")
                        }.padding()
                    }).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                NavigationLink(
                    destination: HelpView(),
                    label: {
                        HStack{
                            Text("Ajuda")
                                .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                            Spacer()
                            Image(systemName: "globe")
                        }.padding()
                    }).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                NavigationLink(
                    destination: AboutView(),
                    label: {
                        HStack{
                            Text("Sobre")
                                .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                            Spacer()
                            Image(systemName: "questionmark.circle")
                        }.padding()
                    }).foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
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
