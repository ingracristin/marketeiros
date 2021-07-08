//
//  CreateIdeaSceneView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 07/07/21.
//

import SwiftUI

struct CreateIdeaSceneView: View {
    @ObservedObject var viewModel: CreateIdeaSceneViewModel
    @State var isHidden = true
    
    init(board: Board, pastes: [Paste]) {
        self.viewModel = CreateIdeaSceneViewModel(board: board, pastes: pastes)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    //isHidden.toggle()
                    viewModel.togglePasteSheet()
                }, label: {
                    HStack {
                        Image(systemName: "folder")
                        Spacer()
                    }
                }).padding(.vertical)
                TextField("Título", text: viewModel.bindings.title)
                    .foregroundColor(Color(UIColor.lightGray))
                TextEditor(text: viewModel.bindings.description)
                    .foregroundColor(Color(UIColor.lightGray))
            }.padding()

            HalfModalView(isShown: viewModel.bindings.pasteSheetShowing, modalHeight: 250) {
                ForEach(viewModel.pastes, id:\.uid) { paste in
                    Button(action: {
                        viewModel.select(paste: paste)
                    }) {
                        Label(
                            title: { Text(paste.title) },
                            icon: { Image(systemName: "42.circle") })
                        Divider()
                    }
                }.padding()
            }//.isHidden(isHidden)
        }
        .navigationBarTitle("Criar idéia", displayMode: .inline)
        .navigationBarItems(
            trailing: Button("Salvar", action: {
                viewModel.saveIdea()
        }))
    }
}

struct CreateIdeaSceneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateIdeaSceneView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""), pastes: [.init(uid: "", title: "teu cu", icon: "")])
        }
    }
}
