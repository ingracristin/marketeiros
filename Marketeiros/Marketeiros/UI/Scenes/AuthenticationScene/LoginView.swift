//
//  LoginView.swift
//  Marketeiros
//
//  Created by João Guilherme on 05/07/21.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @State var value : CGFloat = 0
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 20){
            VStack(alignment: .leading){
                Text("E-mail")
                    .font(.title3)
                    .foregroundColor(Color("UnselectedButton"))
                
                TextField("",text: viewModel.bindings.loginEmail)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(20)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0566, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color("TextField"))
                    .cornerRadius(8)
                    
                Text(NSLocalizedString("onlyPass", comment: ""))
                    .font(.title3)
                    .foregroundColor(Color("UnselectedButton"))
                SecureField("",text: viewModel.bindings.loginPassword)
                    .padding(20)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0566, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color("TextField"))
                    .cornerRadius(8)
            }.padding(.horizontal,20)
            
            Spacer().frame(height: 60)
            Button(action: {
                viewModel.signIn()
            }, label: {
                Text(NSLocalizedString("logIn", comment: ""))
                    .font(Font.custom("cocon-bold",size: 20))
                    .bold()
                    .foregroundColor(.white)
            })
            .padding(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
            .background(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)))
            .cornerRadius(20)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
    }
}
