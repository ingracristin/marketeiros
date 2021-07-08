//
//  RegisterView.swift
//  Marketeiros
//
//  Created by João Guilherme on 05/07/21.
//

import SwiftUI
import AuthenticationServices

struct RegisterView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @State var value : CGFloat = 0
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 20) {
            VStack{
                TextField("Nome",text: viewModel.bindings.name)
                    .padding(20)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color("TextField"))
                    .cornerRadius(18)
                TextField("Nome de usuário",text: viewModel.bindings.username)
                    .padding(20)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color("TextField"))
                    .cornerRadius(18)
                
                TextField("Digite seu email",text: viewModel.bindings.email)
                    .keyboardType(.emailAddress)
                    .padding(20)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0677, alignment: .center)
                    .background(Color("TextField"))
                    .cornerRadius(18)
                
                SecureField("Escolha sua senha",text: viewModel.bindings.password)
                    .padding(20)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color("TextField"))
                    .cornerRadius(18)
                
                SecureField("Repita a sua senha",text: viewModel.bindings.confirmPassword)
                    .padding(20)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color("TextField"))
                    .cornerRadius(18)
            }.padding(.horizontal,20)
        
            Text("Ao criar uma conta você concorda com os termos de serviço e política de privacidade do aplicativo.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 35)
                .foregroundColor(Color(#colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 1)))
            
            Button(action: {
                viewModel.signUp()
            }, label: {
                Text("Criar")
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: .init())
    }
}
