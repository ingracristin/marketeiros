//
//  IdeaCell.swift
//  Marketeiros
//
//  Created by João Guilherme on 17/06/21.
//

import SwiftUI

struct IdeaCell: View {
    @State var newIdea: String = NSLocalizedString("writeIdea", comment: "")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Button(action: {}, label: {
                    Image(systemName: "face.dashed").foregroundColor(Color("iconIdeaColorCell"))
                })
                Button(action: {}, label: {
                    Image(systemName: "folder").foregroundColor(Color("iconIdeaColorCell"))
                })
            }
            TextEditor(text: $newIdea)
                .colorMultiply(Color("ideaColorCell"))
                .background(Color("ideaColorCell"))
            
        }
        .padding(.init(top: 12, leading: 20, bottom: 0, trailing: 20))
        .background(Color("ideaColorCell"))
    }
}

struct IdeaCell_Previews: PreviewProvider {
    static var previews: some View {
        IdeaCell()
    }
}
