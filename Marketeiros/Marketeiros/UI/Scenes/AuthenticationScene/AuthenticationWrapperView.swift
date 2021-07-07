//
//  LoginSceneView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 25/06/21.
//

import SwiftUI

// dps bota tudo na viewmodel
struct AuthenticationWrapperView: View {
    @ObservedObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.states.isLoggedIn {
                    TabBarScene()
                } else  {
                    LoginView(viewModel: viewModel)
                }
            }
            .alert(isPresented: viewModel.bindings.existError) {
                Alert(title: Text("Error"), message: Text(""), dismissButton: .cancel())
            }
            .onAppear {
                if let _ = AuthService.current.user {
                    viewModel.set(isLogged: true)
                } else {
                    viewModel.set(isLogged: false)
                }
            }
        }
    }
}

struct LoginSceneView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationWrapperView()
    }
}

//// dps bota tudo na viewmodel
//struct LoginSceneView: View {
//    @State var isLoggedIn = false
//    @State var existError = false
//    @State var errorMessage = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                if isLoggedIn {
//                    TabBarScene()
//                } else  {
//                    Button {
//                        AuthService.current.signInAnom { result in
//                            switch result {
//                            case .success(let user):
//                                UserRepository.current.initialize(user: user) { result in
//                                    switch result {
//                                    case .failure(.initializationError(let message)):
//                                        errorMessage = message
//                                    case . success(_):
//                                        isLoggedIn.toggle()
//                                    }
//                                }
//                            case .failure(.authenticationError(let message)):
//                                errorMessage = message
//                                existError.toggle()
//                            default:
//                                errorMessage = "Unknown Error"
//                                existError.toggle()
//                            }
//                        }
//                    } label: {
//                        Text("Sign In anom")
//                    }
//                }
//            }
//            .alert(isPresented: $existError) {
//                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .cancel())
//            }
//            .onAppear {
//                AuthService.current.verifyAuthentication { user in
//                    if let _ = user {
//                        isLoggedIn = true
//                    } else {
//                        isLoggedIn = false
//                    }
//                }
//            }
//        }
//    }
//}
