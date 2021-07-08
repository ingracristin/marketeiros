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
        
        ScrollView{
            VStack(spacing: 20){
                Image("header")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.2155, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack{
                    Button(action: {}, label: {
                        Text("Login")
                            .font(Font.custom("cocon-bold",size: 20))
                            .bold()
                            .foregroundColor(.white)
                    }).padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                    .background(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)))
                    .cornerRadius(13)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Text("Criar Conta")
                            .font(Font.custom("cocon-bold",size: 20))
                            .bold()
                            .foregroundColor(Color("UnselectedButton"))

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
                .signInWithAppleButtonStyle(colorScheme == .dark ? .black : .whiteOutline)
                .border(colorScheme == .dark ? Color.white : Color.black.opacity(0))
                .frame(width: UIScreen.main.bounds.size.width * 0.8826, height: UIScreen.main.bounds.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack{
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: UIScreen.main.bounds.size.width * 0.3093, height: 2)
                    
                    Spacer()
                    Text("ou")
                        .foregroundColor(Color.gray)
                    Spacer()
                    
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: UIScreen.main.bounds.size.width * 0.3093, height: 2)
                    
                }.padding(.horizontal,20)
                
                VStack{
                    TextField("Email",text: viewModel.bindings.loginEmail)
                        .keyboardType(.emailAddress)
                        .padding(20)
                        .frame(height: UIScreen.main.bounds.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color("TextField"))
                        .cornerRadius(18)
                    SecureField("Digite sua senha",text: viewModel.bindings.loginPassword)
                        .padding(20)
                        .frame(height: UIScreen.main.bounds.size.height * 0.0677, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color("TextField"))
                        .cornerRadius(18)
                }.padding(.horizontal,20)
                
                Spacer().frame(height: 60)
                Button(action: {
                    viewModel.signIn()
                }, label: {
                    Text("Entrar")
                        .font(Font.custom("cocon-bold",size: 20))
                        .bold()
                        .foregroundColor(.white)
                }).padding(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
                .background(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)))
                .cornerRadius(20)
            }
            .animation(.spring())
            .offset(y: -self.value)
            
            .onAppear{
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (noti) in
                    
                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    
                    let height = value.height
                    self.value = height
                    
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (noti) in
                    
                    self.value = 0
                }
                
                UIApplication.shared.addTapGestureRecognizer()
                
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
    }
}
