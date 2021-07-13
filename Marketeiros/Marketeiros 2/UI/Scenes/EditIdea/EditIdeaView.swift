//
//  EditIdeaView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 12/07/21.
//

import SwiftUI

struct EditIdeaView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: EditIdeaViewModel
    @State var isHidden = true
    var callback: ((Idea?) -> ())?
    
    init(board: Board, paste: Paste, idea: Idea, callback: ((Idea?) -> ())?) {
        self.viewModel = EditIdeaViewModel(board: board, paste: paste, idea: idea)
        self.callback = callback
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    isHidden.toggle()
                    viewModel.togglePasteSheet()
                }, label: {
                    HStack {
                        Image(systemName: "folder")
                        Spacer()
                    }
                }).padding(.vertical)
                TextField("Título", text: viewModel.bindings.title)
                    .foregroundColor(Color(UIColor.lightGray))
                    .font(Font.sfProDisplaySemiBold(sized: 24))
                TextEditor(text: viewModel.bindings.description)
                    .foregroundColor(Color(UIColor.lightGray))
                    .font(Font.sfProDisplaySemiBold(sized: 14))
            }.padding()

            HalfModalView(isShown: viewModel.bindings.pasteSheetShowing, modalHeight: 350) {
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        Button(action: {
                            viewModel.togglePasteSheet()
                        }) {
                            Text("Cancelar")
                                .foregroundColor(.red)
                        }
                        Spacer()
                        Text("Selecionar Pasta da idéia")
                            .font(Font.sfProDisplaySemiBold(sized: 18))
                            .foregroundColor(Color(UIColor.navBarTitleColor))
                        Spacer()
                        Button(action: {
                            viewModel.togglePasteSheet()
                        }) {
                            Text("Salvar")
                                .foregroundColor(Color(UIColor.navBarTitleColor))
                        }
                    }.padding(.bottom)
                    VStack {
                        ForEach(Array(arrayLiteral: viewModel.paste), id:\.uid) { paste in
                            Button(action: {
                                viewModel.select(paste: paste)
                            }) {
                                VStack {
                                    HStack {
                                        Image(systemName: "folder")
                                        Text(paste.title)
                                        Spacer()
                                        if (viewModel.states.paste.uid == paste.uid) {
                                            Image(systemName:"checkmark")
                                        }
                                    }
                                    .foregroundColor(Color(UIColor.navBarTitleColor))
                                    Divider()
                                }
                            }.padding()
                        }
                    }
                }
            }
            .isHidden(!viewModel.bindings.pasteSheetShowing.wrappedValue)
        }
        .navigationBarTitle("Criar idéia", displayMode: .inline)
        .navigationBarItems(
            trailing: Menu(content: {
                Button {
                    viewModel.deleteIdea()
                    callback?(nil)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Label("Deletar", systemImage: "trash")
                }

                Button {
                    viewModel.updateIdea()
                    callback?(viewModel.idea)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Label("Salvar", systemImage: "square.and.arrow.down")
                }
            }, label: {
                Image(systemName: "ellipsis.circle")
            })
               
//            trailing: Button("Salvar", action: {
//                viewModel.updateIdea()
//                callback?(viewModel.idea)
//                presentationMode.wrappedValue.dismiss()
//        })
        
        )
    }
}

struct EditIdeaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateIdeaSceneView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""), pastes: [.init(uid: "", title: "teu cu", icon: "")], completion: nil)
        }
    }
}
