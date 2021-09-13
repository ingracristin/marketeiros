//
//  CustomAlertsModifiers.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 13/09/21.
//

import SwiftUI

extension View {
    func loadingView<T: View>(text: Binding<String>, isPresenting: Binding<Bool>, alert: T) -> some View {
        self.modifier(LoadingViewModifier(isShowing: isPresenting, alert: alert))
    }
}

extension View {
    func customErrorView<T: View>(text: Binding<String>, isPresenting: Binding<Bool>, alert: T) -> some View {
        self.modifier(ErrorViewModifier(isShowing: isPresenting, alert: alert))
    }
}

struct ErrorViewModifier<AlertView: View>: ViewModifier {
    @Binding var isShowing: Bool
    let alert: AlertView
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: self.isShowing ? 5 : 0)
            if isShowing {
                alert
                    .onTapGesture {
                        withAnimation {
                            isShowing.toggle()
                        }
                    }
            }
        }
    }
}

struct LoadingViewModifier<AlertView: View>: ViewModifier {
    @Binding var isShowing: Bool
    let alert: AlertView
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(self.isShowing)
                .blur(radius: self.isShowing ? 5 : 0)
            if isShowing {
                alert
            }
        }
    }
}
