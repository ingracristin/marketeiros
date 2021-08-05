//
//  CreateIdeaSceneView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 07/07/21.
//

import SwiftUI

struct CreateIdeaSceneView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CreateIdeaSceneViewModel
    
    init(board: Board, pastes: [Paste], completion: ((Idea) -> ())?) {
        self.viewModel = CreateIdeaSceneViewModel(board: board, pastes: pastes, completion:completion)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        viewModel.togglePasteSheet()
                    }, label: {
                        HStack {
                            Image(systemName: "folder")
                            Spacer()
                        }
                    }).padding(.vertical)
                    .frame(width:50)
                    Spacer()
                }
                
                TextField("Título", text: viewModel.bindings.title)
                    .foregroundColor(Color(UIColor.lightGray))
                    .font(Font.sfProDisplaySemiBold(sized: 24))
                    .onTapGesture {
                        viewModel.okButtonIsShowing(true)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        viewModel.okButtonIsShowing(false)
                    }
                TextEditor(text: viewModel.bindings.description)
                    .foregroundColor(Color(UIColor.lightGray))
                    .font(Font.sfProDisplaySemiBold(sized: 14))
                    .onTapGesture {
                        viewModel.okButtonIsShowing(true)
                        if viewModel.states.description == NSLocalizedString("descriptionIdea", comment: "") {
                            viewModel.setDescriptionwith(text: "")
                        }
                    }
            }.padding()

            HalfModalView(isShown: viewModel.bindings.pasteSheetShowing, modalHeight: 350) {
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        Button(action: {
                            viewModel.setNonePaste()
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
                        ForEach(viewModel.pastes, id:\.uid) { paste in
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
        .navigationBarTitle("Idea",displayMode: .inline)
        .navigationBarItems(trailing:
            HStack(spacing:20) {
                Menu {
                    Button(action:{}) {
                        HStack{
                            Text(NSLocalizedString("delete", comment: ""))
                            Image(systemName: "trash")
                        }.foregroundColor(.red)
                    }

                } label: {
                    Image(systemName: "ellipsis.circle")
                }.foregroundColor(Color(UIColor.navBarItemsColor))
                if viewModel.states.okButtonShowing {
                    Button {
                        viewModel.saveIdea()
                    } label: {
                        Text("ok")
                            .fontWeight(.semibold)
                    }
                }
            }
        )
    }
}

struct CreateIdeaSceneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateIdeaSceneView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""), pastes: [.init(uid: "", title: "teu cu", icon: "")], completion: nil)
        }
    }
}
