//
//  BoardCell.swift
//  Marketeiros
//
//  Created by João Guilherme on 16/06/21.
//

import SwiftUI

struct BoardCell: View {
    
    
    var body: some View {
        
        GeometryReader(){ reader in
            ZStack(alignment: .bottomLeading){
                Image("test").resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .frame(width: reader.size.width, height: reader.size.height,alignment: .center)
            
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0.3098039216, green: 0.3058823529, blue: 0.3058823529, alpha: 1)))
                        .opacity(0.7)
                        .frame(height: reader.size.height * 0.33)
                
                VStack(alignment: .leading){
                    Text("Nome quadro")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Text("pode ser uma bio aqui")
                        .foregroundColor(.white)
                        
                    
                }.frame(height: reader.size.height * 0.33)
                .padding(.init(top: 0, leading: 20, bottom: 5, trailing: 0))
               
                
                
                   
                
                
                
                
            }
                
            
        }
    }
}

struct BoardCell_Previews: PreviewProvider {
    static var previews: some View {
        BoardCell()
    }
}
