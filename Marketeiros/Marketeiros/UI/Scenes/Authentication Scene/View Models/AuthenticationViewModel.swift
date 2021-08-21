//
//  AuthenticationViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 06/07/21.
//

import Foundation
import SwiftUI
import AuthenticationServices
import CryptoKit

class AuthenticationViewModel: ObservableObject {
    struct States {
        var loginEmail = ""
        var loginPassword = ""
        var name = ""
        var username = ""
        var email = ""
        var password = ""
        var confirmPassword = ""
        var isLoading = false
        var nonce = ""
        var isLoggedIn = false
        var existError = false
        var errorText = "Error Description"
    }
    
    @Published private(set) var states = States()
    
    var bindings : (
        loginEmail: Binding<String>,
        loginPassword: Binding<String>,
        name: Binding<String>,
        username: Binding<String>,
        email: Binding<String>,
        password: Binding<String>,
        confirmPassword: Binding<String>,
        isLoading: Binding<Bool>,
        isLoggedIn: Binding<Bool>,
        existError: Binding<Bool>,
        errorText: Binding<String>
    ) {(
        loginEmail: Binding(
            get: {self.states.loginEmail},
            set: {self.states.loginEmail = $0}),
        loginPassword: Binding(
            get: {self.states.loginPassword},
            set: {self.states.loginPassword = $0}),
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
            set: {self.states.isLoading = $0}),
        isLoggedIn: Binding(
            get: {self.states.isLoggedIn},
            set: {self.states.isLoggedIn = $0}),
        existError: Binding(
            get: {self.states.existError},
            set: {self.states.existError = $0}),
        errorText: Binding(
            get: {self.states.errorText},
            set: {self.states.errorText = $0})
    )}
    
    func signIn() {
        self.states.isLoading.toggle()
        AuthService.current.signInWithEmailAndPassword(email: states.loginEmail, password: states.loginPassword) { [weak self] result in
            self?.states.isLoading.toggle()
            switch result {
            case .failure(let error):
                self?.states.errorText = error.localizedDescription
                self?.states.existError.toggle()
            case .success(_):
                self?.states.isLoggedIn.toggle()
            }
        }
    }
    
    func signUp() {
        states.isLoading.toggle()
        let name = states.name
        let username = states.username
        
        if name.isEmpty ||
           username.isEmpty ||
            states.email.isEmpty ||
           states.password.isEmpty ||
           states.email.isEmpty {
           
            states.isLoading.toggle()
            states.errorText = NSLocalizedString("All fields must be filled in correctly.", comment: "")
            states.existError.toggle()
            return
        }
        
        if states.password != states.confirmPassword {
            states.isLoading.toggle()
            states.errorText = NSLocalizedString("Password must be equal on the two fields!", comment: "")
            states.existError.toggle()
            return
        }
        
        AuthService.current.createUserWithEmailAndPassword(email: states.email, password: states.password, name: states.name) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.states.errorText = error.localizedDescription
                self?.states.isLoading.toggle()
                self?.states.existError.toggle()
            case .success(let user):
                self?.initialize(user: user, with: name, and: username)
            }
        }
    }
    
    func signUpWithApple(authorization: ASAuthorization) {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = credentials.identityToken,
              let appleIDTokenString = String(data: identityToken, encoding: .utf8) else { return }
        
        let givenName = credentials.fullName?.givenName ?? ""
        let lastName = credentials.fullName?.familyName ?? ""
        let userNameFullName = "\(givenName) \(lastName)"
        
        states.isLoading.toggle()
        AuthService.current.signInWith(appleIDTokenString: appleIDTokenString, and: states.nonce) { result in
            switch result {
            case .failure(let error):
                self.states.errorText = error.localizedDescription
                self.states.isLoading.toggle()
                self.states.existError.toggle()
            case .success(let user):
                if givenName.isEmpty {
                    self.states.isLoading.toggle()
                    self.states.isLoggedIn.toggle()
                } else {
                    self.initialize(user: user, with: userNameFullName, and: givenName)
                }
            }
        }
    }
    
    private func initialize(user: User, with name: String, and username: String) {
        UserProfileRepository.current.initialize(user: UserProfile(uid: user.uid, email: user.email, name: name, username: username)) {  [weak self] result in
            switch result {
                case .failure(let error):
                    self?.states.errorText = error.localizedDescription
                    self?.states.isLoading.toggle()
                    self?.states.existError.toggle()
                case .success(_):
                    var  board = Board.init(
                        uid: "",
                        imagePath: "",
                        title: "Plani Board",
                        description: "",
                        instagramAccount: "",
                        ownerUid: user.uid,
                        colaboratorsUids: [],
                        postsGridUid: "",
                        ideasGridUid: "",
                        moodGridUid: "")
                    BoardsRepository.current.create(board: &board) { [weak self] result in
                        self?.states.isLoading.toggle()
                        switch result {
                        case .failure(let error):
                            self?.states.existError.toggle()
                            self?.states.errorText = error.localizedDescription
                        case .success(_):
                            LocalRepository.shared.saveCurrent(board: board)
                            if let self = self {
                                self.states.isLoggedIn.toggle()
                            }
                    }
                }
            }
        }
    }
    
    func signOut() {
        AuthService.current.signOut { [weak self]result in
            if let self = self {
                self.set(isLogged: false)
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
    
    func set(isLogged: Bool) {
        states.isLoggedIn = isLogged
    }
}
