//
//  AuthenticationView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 08/07/21.
//

import SwiftUI
import AuthenticationServices

struct AuthenticationView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @State var value : CGFloat = 0
    @State var selectedIndex = 0
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        LoadingView(isShowing: viewModel.bindings.isLoading) {
            ScrollView {
                VStack(spacing: 20){
                    Image("header")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.2155, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    HStack{
                        Button(action: {
                            selectedIndex = 0
                        }, label: {
                            Text("Login")
                                .font(Font.coconBold(sized: 20))
                                .bold()
                                .foregroundColor((selectedIndex == 0) ? .white : Color(UIColor.unselectedColor))
                        })
                        .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                        .background((selectedIndex == 0) ? Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)) : nil)
                        .cornerRadius(13)
                        Spacer()
                        
                        Button(action: {
                            selectedIndex = 1
                        }, label: {
                            Text(NSLocalizedString("createAcc", comment: ""))
                                .font(Font.custom("cocon-bold",size: 20))
                                .bold()
                                .foregroundColor((selectedIndex == 1) ? .white : Color(UIColor.unselectedColor))
                        })
                        .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                        .background((selectedIndex == 1) ? Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)) : nil)
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
                        Text(NSLocalizedString("or", comment: ""))
                            .foregroundColor(Color.gray)
                        Spacer()
                        
                        Capsule()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: UIScreen.main.bounds.size.width * 0.3093, height: 2)
                        
                    }.padding(.horizontal,20)
                    
                    if selectedIndex == 0 {
                        LoginView(viewModel: viewModel)
                    } else {
                        RegisterView(viewModel: viewModel)
                    }
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
            .alert(isPresented: viewModel.bindings.existError) {
                Alert(title: Text("Error"), message: Text(viewModel.states.errorText), dismissButton: .cancel())
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(viewModel: .init())
    }
}

