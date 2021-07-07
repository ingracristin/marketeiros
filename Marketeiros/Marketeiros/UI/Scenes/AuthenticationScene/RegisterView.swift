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
    
    var body: some View {
        GeometryReader{ reader in
            ScrollView{
                VStack(spacing: 20){
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: reader.size.width, height: reader.size.height * 0.2155, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    HStack{
                        NavigationLink(destination:
                            LoginView(viewModel: viewModel)
                        , label: {
                            Text("Login")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.black)
                        })
                        .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                        .cornerRadius(13)
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("Criar Conta")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                        })
                        .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                        .background(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)))
                        .cornerRadius(13)
                    }.padding(.horizontal,20)
                    
                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.fullName,.email]
                    } onCompletion: { result in
                        switch result {
                        case .success(_):
                            print("Authorisation successful")
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
                        TextField("Nome",text: viewModel.bindings.name)
                            .padding(20)
                            .frame(height: reader.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color(#colorLiteral(red: 0.948936522, green: 0.9490728974, blue: 0.9489067197, alpha: 1)))
                            .cornerRadius(18)
                        TextField("Nome de usuário",text: viewModel.bindings.username)
                            .padding(20)
                            .frame(height: reader.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color(#colorLiteral(red: 0.948936522, green: 0.9490728974, blue: 0.9489067197, alpha: 1)))
                            .cornerRadius(18)
                        
                        TextField("Digite seu email",text: viewModel.bindings.email)
                            .padding(20)
                            .frame(height: reader.size.height * 0.0677, alignment: .center)
                            .background(Color(#colorLiteral(red: 0.948936522, green: 0.9490728974, blue: 0.9489067197, alpha: 1)))
                            .cornerRadius(18)
                        
                        TextField("Escolha sua senha",text: viewModel.bindings.password)
                            .padding(20)
                            .frame(height: reader.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color(#colorLiteral(red: 0.948936522, green: 0.9490728974, blue: 0.9489067197, alpha: 1)))
                            .cornerRadius(18)
                        
                        TextField("Repita a sua senha",text: viewModel.bindings.confirmPassword)
                            .padding(20)
                            .frame(height: reader.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color(#colorLiteral(red: 0.948936522, green: 0.9490728974, blue: 0.9489067197, alpha: 1)))
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
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    })
                    
                    .padding(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
                    .background(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)))
                    .cornerRadius(20)
                    
                }
                
                .navigationBarHidden(true)
                
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: .init())
    }
}
