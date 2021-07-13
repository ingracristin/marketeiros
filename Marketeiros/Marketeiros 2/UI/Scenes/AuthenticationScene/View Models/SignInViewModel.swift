//
//  SigninViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 06/07/21.
//

import Foundation
import SwiftUI
import AuthenticationServices
import CryptoKit

class SignInViewModel: ObservableObject {
    struct States {
        var email = ""
        var password = ""
        var nonce = ""
    }
    
    private(set) var states = States()
    
    var bindings : (
        email: Binding<String>,
        password: Binding<String>
    ) {(
        email: Binding(
            get: {self.states.email},
            set: {self.states.email = $0}),
        password: Binding(
            get: {self.states.password},
            set: {self.states.password = $0})
    )}
    
    func signIn() {
        AuthService.current.signInWithEmailAndPassword(email: states.email, password: states.password) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let user):
                print(user.name)
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
//                    UserRepository.current.initialize(user: user, completion: <#T##(Result<User, UserRepository.UserRepositoryErrors>) -> ()#>)
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
