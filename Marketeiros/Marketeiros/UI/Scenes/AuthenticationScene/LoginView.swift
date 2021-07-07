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
    
    var body: some View {
        GeometryReader{ reader in
            VStack(spacing: 20){
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: reader.size.width, height: reader.size.height * 0.2155, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack{
                    Button(action: {}, label: {
                        Text("Login")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }).padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                    .background(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)))
                    .cornerRadius(13)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Text("Criar Conta")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                    }).padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                    
                    .cornerRadius(13)
                }.padding(.horizontal,20)
                
                
                SignInWithAppleButton(.signIn) { request in
                    let nonce = viewModel.randomNonceString()
                    request.requestedScopes = [.fullName, .email]
                    request.nonce = viewModel.sha256(nonce)
                } onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        viewModel.signUpWithApple(authorization: authorization)
                    case .failure(let error):
                        print("Authorisation failed: \(error.localizedDescription)")
                    }
                }
                .signInWithAppleButtonStyle(.whiteOutline)
                .frame(width: reader.size.width * 0.8826, height: reader.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack{
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: reader.size.width * 0.3093, height: 2)
                    
                    Spacer()
                    Text("ou")
                        .foregroundColor(Color.gray)
                    Spacer()

                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: reader.size.width * 0.3093, height: 2)
                        
                }.padding(.horizontal,20)
                
                VStack{
                    TextField("Email",text: viewModel.bindings.loginEmail)
                        .padding(20)
                        .frame(width: .infinity, height: reader.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(#colorLiteral(red: 0.948936522, green: 0.9490728974, blue: 0.9489067197, alpha: 1)))
                        .cornerRadius(18)
                    TextField("Digite sua senha",text: viewModel.bindings.loginPassword)
                        .padding(20)
                        .frame(width: .infinity, height: reader.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(#colorLiteral(red: 0.948936522, green: 0.9490728974, blue: 0.9489067197, alpha: 1)))
                        .cornerRadius(18)
                }.padding(.horizontal,20)
                
                Spacer().frame(height: 60)
                Button(action: {
                    viewModel.signIn()
                }, label: {
                    Text("Entrar")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }).padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                .background(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)))
                .cornerRadius(20)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
    }
}
