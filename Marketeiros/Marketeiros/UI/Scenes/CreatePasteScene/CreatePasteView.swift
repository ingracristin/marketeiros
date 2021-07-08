//
//  CreatePasteView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 07/07/21.
//

import SwiftUI

struct CreatePasteView: View {
    @State var title: String = ""
    var board: Board
    
    var body: some View {
        VStack(spacing: 20){
            TextField("Nome da pasta", text: $title)
            Button(action: {
                var paste = Paste(uid: "", title: title, icon: "none")
                BoardsRepository.current.add(item: &paste, to: board, on: .pastes)
            }, label: {
                Text("Salvar")
            })
            Spacer()
        }.padding()
    }
}

struct CreatePasteView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasteView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
    }
}
