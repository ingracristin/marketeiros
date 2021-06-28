//
//  LoginSceneView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 25/06/21.
//

import SwiftUI

// dps bota tudo na viewmodel
struct LoginSceneView: View {
    @State var isLoggedIn = false
    @State var existError = false
    @State var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: BoardView(), isActive: $isLoggedIn) { EmptyView() }
                
                Button {
                    AuthService.current.signInAnom { result in
                        switch result {
                        case .success(let user):
                            UserRepository.current.initialize(user: user) { result in
                                switch result {
                                case .failure(.initializationError(let message)):
                                    errorMessage = message
                                case . success(_):
                                    isLoggedIn.toggle()
                                }
                            }   
                        case .failure(.authenticationError(let message)):
                            errorMessage = message
                            existError.toggle()
                        default:
                            errorMessage = "Unknown Error"
                            existError.toggle()
                        }
                    }
                } label: {
                    Text("Sign In anom")
                }
            }
            .alert(isPresented: $existError) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .cancel())
            }
            .onAppear {
                guard let user = AuthService.current.user else { return }
                isLoggedIn.toggle()
            }
        }
    }
}

struct LoginSceneView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSceneView()
    }
}
