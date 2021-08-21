//
//  LoginSceneView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 25/06/21.
//

import SwiftUI

struct AuthenticationWrapperView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            if viewModel.states.isLoggedIn {
               TabBarScene()
            } else  {
                AuthenticationView(viewModel: viewModel)
            }
        }
        .onAppear {
            if UserDefaults.standard.object(forKey: "authError") == nil {
                viewModel.signOut()
                UserDefaults.standard.setValue(true, forKey: "authError")
            }

            if let _ = AuthService.current.user {
                viewModel.set(isLogged: true)
            } else {
                viewModel.set(isLogged: false)
            }
        }
        .environmentObject(viewModel)
    }
}

struct LoginSceneView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationWrapperView()
    }
}
