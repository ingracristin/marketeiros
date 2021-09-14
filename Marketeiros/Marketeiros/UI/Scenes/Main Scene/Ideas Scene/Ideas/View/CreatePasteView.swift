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
    var callback: ((Paste) -> Void)?
    
    var body: some View {
        VStack(spacing: 20){
            ZStack {
                HStack {
                    Spacer()
                    Text(NSLocalizedString("newFilter", comment: ""))
                        .font(Font.sfProDisplaySemiBold(sized: 18))
                        .foregroundColor(Color(UIColor.navBarTitleColor))
                    Spacer()
                }
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(NSLocalizedString("cancel", comment: ""))
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button(action: {
                        var paste = Paste(uid: "", title: title, icon: "none")
                        BoardsRepository.current.add(item: &paste, to: board, on: .pastes)
                        callback?(paste)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(NSLocalizedString("save", comment: ""))
                            .foregroundColor(Color(UIColor.navBarItemsColor))
                    }
                }.padding(.vertical)
            }
                
            VStack(spacing:5) {
                TextField(NSLocalizedString("filterName", comment: ""), text: $title)
                Divider()
            }
            Spacer()
        }
        .padding()
        .cornerRadius(50)
    }
}

struct CreatePasteView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasteView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""), callback: nil)
    }
}
