//
//  AcountListCellSwiftUIView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 17/06/21.
//

import SwiftUI

struct AcountListCellSwiftUIView: View {
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.yellow)
                .frame(width: 390, height: 50)
            
            HStack(){
                Image("instagram")
                Text("@contas")
                Spacer()
                HStack(spacing: -8){
                    ForEach(0..<2, id:\.self){ index in
                        Circle().frame(width: 17, height: 17)
                    }
                        
                }
            }.padding(.horizontal,25)

           

        }
    }
}

struct AcountListCellSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AcountListCellSwiftUIView()
    }
}
