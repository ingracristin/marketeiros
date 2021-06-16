//
//  BoardCell.swift
//  Marketeiros
//
//  Created by João Guilherme on 16/06/21.
//

import SwiftUI

struct BoardCell: View {
    var body: some View {
        VStack{
            HStack{
                Text("Board 1")
                
            }
        }
        .background(Color(#colorLiteral(red: 0.8469843268, green: 0.8471066356, blue: 0.8469573855, alpha: 1)))
    }
}

struct BoardCell_Previews: PreviewProvider {
    static var previews: some View {
        BoardCell()
    }
}
