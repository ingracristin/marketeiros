//
//  IdeaCell.swift
//  Marketeiros
//
//  Created by João Guilherme on 17/06/21.
//

import SwiftUI

struct IdeaCell: View {
    @State var newIdea: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button(action: {}, label: {
                    Image(systemName: "face.dashed").foregroundColor(Color(#colorLiteral(red: 0.3450980392, green: 0.2901960784, blue: 0.2901960784, alpha: 1)))
                    
                })
                Button(action: {}, label: {
                    Image(systemName: "folder").foregroundColor(Color(#colorLiteral(red: 0.3450980392, green: 0.2901960784, blue: 0.2901960784, alpha: 1)))
                    
                })
            }
            TextField("Teve uma nova super ideia? Escreva aqui para não esquecer!", text: $newIdea)
            
        }.padding(.horizontal,20)
       
    }
}

struct IdeaCell_Previews: PreviewProvider {
    static var previews: some View {
        IdeaCell()
    }
}
