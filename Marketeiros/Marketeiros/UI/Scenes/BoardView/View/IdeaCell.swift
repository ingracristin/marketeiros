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
        VStack(alignment: .leading, spacing: 0){
            HStack{
//                Button(action: {}, label: {
//                    Image(systemName: "face.dashed").foregroundColor(Color("iconIdeaColorCell"))
//                })
                Button(action: {}, label: {
                    Image(systemName: "folder").foregroundColor(Color("iconIdeaColorCell"))
                })
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom,0)
            ZStack {
                TextEditor(text: $newIdea)
                    .font(Font.sfProDisplayRegular(sized: 14))
                    .foregroundColor(Color.gray)
                    .background(Color("ideaColorCell"))
                    .onTapGesture {
                        if newIdea == NSLocalizedString("writeIdea", comment: "") {
                            newIdea = ""
                        }
                    }
                Text(newIdea).opacity(0).padding(.all,8)
            }
            .padding(.vertical,8)
            .padding(.horizontal)
        }
        //.padding(.init(top: 12, leading: 20, bottom: 0, trailing: 20))
        .background(Color("ideaColorCell"))
    }
}

struct IdeaCell_Previews: PreviewProvider {
    static var previews: some View {
        IdeaCell()
    }
}
