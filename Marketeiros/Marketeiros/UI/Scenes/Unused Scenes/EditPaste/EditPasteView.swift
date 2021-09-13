//
//  EditPasteView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 12/07/21.
//

import SwiftUI

struct EditPasteView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String
    var paste: Paste
    var callback: ((Paste) -> ())?
    var board: Board
    
    init(currentPaste: Paste, board: Board,callback: ((Paste) -> ())?) {
        _title = State(initialValue: currentPaste.title)
        self.callback = callback
        self.board = board
        self.paste = currentPaste
    }
    
    var body: some View {
        VStack(spacing: 20){
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(NSLocalizedString("cancel", comment: ""))
                        .foregroundColor(.red)
                }
                Spacer()
                Text(NSLocalizedString("newFolder", comment: ""))
                    .font(Font.sfProDisplaySemiBold(sized: 18))
                    .foregroundColor(Color(UIColor.navBarTitleColor))
                Spacer()
                Button(action: {
                    var newPaste = Paste(uid: paste.uid, title: title, icon: paste.icon)
                    
                    BoardsRepository.current.update(item: &newPaste, to: board, on: .pastes)
                    callback?(newPaste)
                    presentationMode.wrappedValue.dismiss()

                }) {
                    Text(NSLocalizedString("save", comment: ""))
                        .foregroundColor(Color(UIColor.navBarItemsColor))
                }
            }.padding(.vertical)
            
            TextField(NSLocalizedString("folderName", comment: ""), text: $title)
            Spacer()
        }
        .padding()
        .navigationTitle(NSLocalizedString("newFolder", comment: ""))
    }
}

struct EditPasteView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasteView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""), callback: {_ in })
    }
}
