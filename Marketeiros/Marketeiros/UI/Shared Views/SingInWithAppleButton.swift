//
//  SingInWithAppleButton.swift
//  Marketeiros
//
//  Created by João Guilherme on 20/08/21.
//

import SwiftUI
import AuthenticationServices

struct SingInWithAppleButton: UIViewRepresentable {
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
    
    @Environment(\.colorScheme) var colorScheme
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(
              authorizationButtonType: .signIn,
            authorizationButtonStyle: colorScheme == .dark ? .black : .white)
        button.layer.borderWidth = 1
        button.layer.borderColor = colorScheme == .dark ? UIColor.white.cgColor : nil
        button.layer.cornerRadius = 18
             
            return button
    }
}

struct SingInWithAppleButton_Previews: PreviewProvider {
    static var previews: some View {
        SingInWithAppleButton()
    }
}
