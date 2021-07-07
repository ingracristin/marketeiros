//
//  ProfileMvpView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 07/07/21.
//

import SwiftUI

struct ProfileMvpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isShow = false
    @State private var showingPopover = false
    
    var body: some View {
        VStack() {
            HStack() {
                VStack() {
                    Text("Ingra Cristina")
                    Text("@ingracristic")
                }.padding()
                Spacer()
                Image("bolinha")
                    .padding()
            }
          
            NavigationLink(
                destination: AboutView(),
                label: {
                    HStack{
                        Text("Conta")
                            .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                        Spacer()
                        Image(systemName: "person")
                    }.padding()
                })
                    
            HStack{
                Text("Notificações")
                    .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                Spacer()
                Image(systemName: "bell")
            }.padding()
            HStack{
                Text("Ajuda")
                    .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                Spacer()
                Image(systemName: "globe")
            }.padding()
            HStack{
                Text("Sobre")
                    .font(.custom("SF Pro Display", size: 22, relativeTo: .headline))
                Spacer()
                Image(systemName: "questionmark.circle")
            }.padding()
           Spacer()
            //bell
            //globe
            //questionmark.circle
        }.padding()
        .navigationTitle("Perfil")
        
    }
    
}

struct ProfileMvpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileMvpView()
        }
        
    }
}
