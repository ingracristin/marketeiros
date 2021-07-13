//
//  CreatePasteView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 07/07/21.
//

import SwiftUI

struct CreatePasteView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String = ""
    var board: Board
    
    var body: some View {
        VStack(spacing: 20){
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancelar")
                        .foregroundColor(.red)
                }
                Spacer()
                Text("Nova Pasta")
                    .font(Font.sfProDisplaySemiBold(sized: 18))
                    .foregroundColor(Color(UIColor.navBarTitleColor))
                Spacer()
                Button(action: {
                    var paste = Paste(uid: "", title: title, icon: "none")
                    BoardsRepository.current.add(item: &paste, to: board, on: .pastes)
                    presentationMode.wrappedValue.dismiss()

                }) {
                    Text("Salvar")
                        .foregroundColor(Color(UIColor.navBarItemsColor))
                }
            }.padding(.vertical)
            
            TextField("Nome da pasta", text: $title)
            Spacer()
        }
        .padding()
        .navigationTitle("Criar idéia")
    }
}

struct CreatePasteView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasteView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
    }
}
