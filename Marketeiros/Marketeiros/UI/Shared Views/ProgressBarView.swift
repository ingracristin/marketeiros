//
//  LoadingView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 12/07/21.
//

import SwiftUI

struct ProgressBarView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    @Binding var value: Float
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Saving...")
                        .cellTitle()
                    ProgressBar(value: $value)
                        .frame(height: 15)
                        .padding()
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(isShowing: .constant(true), value: .constant(5)) {
            Text("")
        }
    }
}
