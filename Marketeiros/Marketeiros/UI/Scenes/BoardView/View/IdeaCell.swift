//
//  IdeaCell.swift
//  Marketeiros
//
//  Created by João Guilherme on 17/06/21.
//

import SwiftUI

struct IdeaCell: View {
    @State var newIdea: String = "Teve uma nova super ideia? Escreva aqui para não esquecer!"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Button(action: {}, label: {
                    Image(systemName: "face.dashed").foregroundColor(Color(#colorLiteral(red: 0.3450980392, green: 0.2901960784, blue: 0.2901960784, alpha: 1)))
                    
                })
                Button(action: {}, label: {
                    Image(systemName: "folder").foregroundColor(Color(#colorLiteral(red: 0.3450980392, green: 0.2901960784, blue: 0.2901960784, alpha: 1)))
                    
                })
            }
            TextEditor(text: $newIdea)
                .foregroundColor(Color(#colorLiteral(red: 0.5528908968, green: 0.5529734492, blue: 0.5528727174, alpha: 1)))
                .colorMultiply(Color(#colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)))
            
            
            
        }.padding(.init(top: 12, leading: 20, bottom: 0, trailing: 20))
        
        
    }
}

struct IdeaCell_Previews: PreviewProvider {
    static var previews: some View {
        IdeaCell()
    }
}
