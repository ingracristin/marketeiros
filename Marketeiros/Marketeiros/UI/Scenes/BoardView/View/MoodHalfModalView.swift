//
//  MoodHalfModalView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 05/07/21.
//

import SwiftUI

struct MoodHalfModalView : View {
    @Binding var offset : CGFloat

    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.blue)
            VStack() {
                HStack{
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 50, height: 5)
                        .padding(.top)
                        .padding(.bottom,5)
                }.padding(.bottom)
                
                HStack{
                    Image("fotinha")
                    Text("hmmmm")
                    Spacer()
                }.padding(.all,10)
                .padding()
                HStack{
                    Image("camera")
                    Text("hmmmm")
                    Spacer()
                }.padding(.all,10)
                .padding()
            
                Spacer()
              
            }
        }
        //.background(Color.blue)
        .cornerRadius(30)
    }
}

struct MoodHalfModalView_Previews: PreviewProvider {
    static var previews: some View {
        MoodHalfModalView(offset: .constant(0))
    }
}
