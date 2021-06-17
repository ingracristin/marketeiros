//
//  BoardCell.swift
//  Marketeiros
//
//  Created by João Guilherme on 16/06/21.
//

import SwiftUI

struct BoardCell: View {
    init(){
        
    }
    
    var body: some View {
        
        GeometryReader{ reader in
            VStack(spacing: 0){
                HStack{
                    Text("Board 1")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {}, label: {
                        Text("...")
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.bold)
                        
                        
                    })
                }
                HStack{
                    Circle()
                        .fill(Color.gray)
                        .frame(width: reader.size.width * 0.15, height: reader.size.width * 0.15)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        Image(systemName: "plus.circle").resizable()
                            .foregroundColor(Color(#colorLiteral(red: 0.6730545163, green: 0.658370316, blue: 0.6585103273, alpha: 1)))
                    }.frame(width: reader.size.width * 0.15, height: reader.size.width * 0.15)
                    Spacer()
                }
                
                
                Spacer()
                    
            }
            .padding()
            .background(Color(#colorLiteral(red: 0.8469843268, green: 0.8471066356, blue: 0.8469573855, alpha: 1)))
        }
    }
}

struct BoardCell_Previews: PreviewProvider {
    static var previews: some View {
        BoardCell()
    }
}
