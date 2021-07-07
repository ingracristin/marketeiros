//
//  SignUpViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 06/07/21.
//

import Foundation
import SwiftUI
import AuthenticationServices
import CryptoKit

class SignUpViewModel: ObservableObject {
    struct States {
        var name = ""
        var username = ""
        var email = ""
        var password = ""
        var confirmPassword = ""
        var isLoading = false
        var nonce = ""
    }
    
    private(set) var states = States()
    
    var bindings : (
        name: Binding<String>,
        username: Binding<String>,
        email: Binding<String>,
        password: Binding<String>,
        confirmPassword: Binding<String>,
        isLoading: Binding<Bool>
    ) {(
        name: Binding(
            get: {self.states.name},
            set: {self.states.name = $0}),
        username: Binding(
            get: {self.states.username},
            set: {self.states.username = $0}),
        email: Binding(
            get: {self.states.email},
            set: {self.states.email = $0}),
        password: Binding(
            get: {self.states.password},
            set: {self.states.password = $0}),
        confirmPassword: Binding(
            get: {self.states.confirmPassword},
            set: {self.states.confirmPassword = $0}),
        isLoading: Binding(
            get: {self.states.isLoading},
            set: {self.states.isLoading = $0})
    )}
    
    func signUp() {
        AuthService.current.createUserWithEmailAndPassword(email: states.email, password: states.password, name: states.name) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let user):
                print(user.email)
            }
        }
    }
    
    func signUpWithApple(authorization: ASAuthorization) {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = credentials.identityToken,
              let appleIDTokenString = String(data: identityToken, encoding: .utf8) else { return }
        
        AuthService.current.signInWith(appleIDTokenString: appleIDTokenString, and: states.nonce) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let user):
                if user.name.isEmpty {
                    
                } else {
                    UserRepository.current.initialize(user: user) { result in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let user):
                            
                        }
                    }
                }
            }
        }
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
        }.joined()

        return hashString
    }
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        states.nonce = result
        return result
    }

}
