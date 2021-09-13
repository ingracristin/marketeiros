//
//  TestAlertsModifiers.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 13/09/21.
//


import SwiftUI

struct testErrorView: View {
    @State var isShowing = false
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isShowing.toggle()
                }
                
            }, label: {
                Text("jjdhdhdhdhdh")
            })
            
           Spacer()
        }
        .customErrorView(text: .constant("aaaaa"), isPresenting: $isShowing, alert: LoadingPhotosView(isShowing: $isShowing))
    }
}

struct testErrorView_Previews: PreviewProvider {
    static var previews: some View {
        testErrorView()
    }
}
