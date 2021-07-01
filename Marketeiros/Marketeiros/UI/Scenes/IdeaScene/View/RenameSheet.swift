//
//  RenameSheet.swift
//  Marketeiros
//
//  Created by João Guilherme on 01/07/21.
//

import SwiftUI

struct RenameSheet: View {
    @State var name : String = ""
    var body: some View {
        VStack(alignment: .leading,spacing:15){
            HStack{
                Spacer()
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.top)
                    .padding(.bottom,5)
                Spacer()
            }
            
            HStack{
                Spacer()
                Text("Renomear")
                    .font(.title3)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                Spacer()
            }
            TextField("",text: $name)
                .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                .background(Color(#colorLiteral(red: 0.8469843268, green: 0.8471066356, blue: 0.8469573855, alpha: 1)))
                
        }
    }
}

struct RenameSheet_Previews: PreviewProvider {
    static var previews: some View {
        RenameSheet()
    }
}
