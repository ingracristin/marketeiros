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
    var callback: ((Idea?) -> ())?
    @State var offset: CGFloat = 0
    @State var isCollpsed: Bool = true
    
    func toggleBottomSheet() {
        withAnimation {
            offset = isCollpsed ? 350 : 0
            isCollpsed.toggle()
        }
    }
    
    init(board: Board, paste: Paste, idea: Idea, callback: ((Idea?) -> ())?) {
        self.viewModel = EditIdeaViewModel(board: board, paste: paste, idea: idea)
        self.callback = callback
    }
    
    var body: some View {
        IdeasBottomSheetView(offset: $offset, isCollpsed: $isCollpsed) {
            VStack {
                CustomNavBar(title:NSLocalizedString("editIdea", comment: ""), backButtonAction: {
                    presentationMode.wrappedValue.dismiss()
                }, trailing: {
                    Menu(content: {
                        Button {
                            viewModel.updateIdea()
                            callback?(viewModel.idea)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Label(NSLocalizedString("save", comment: ""), systemImage: "square.and.arrow.down")
                        }
                        Button {
                            viewModel.setErrorAlertIsShowing(true)
                        } label: {
                            Label(NSLocalizedString("delIdea", comment: ""), systemImage: "trash")
                        }
                    }, label: {
                        Image(systemName: "ellipsis.circle")
                    })
                })
                Button(action: {
                    toggleBottomSheet()
                    //viewModel.togglePasteSheet()
                }, label: {
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("NavBarTitle"))
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
            Spacer()
        } sheet: {
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Button(action: {
                        //viewModel.togglePasteSheet()
                        toggleBottomSheet()
                    }) {
                        Text(NSLocalizedString("cancel", comment: ""))
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Text(NSLocalizedString("Categorizar   ", comment: "")) //trad
                        .font(Font.sfProDisplaySemiBold(sized: 18))
                        .foregroundColor(Color(UIColor.navBarTitleColor))
                    Spacer()
                    Button(action: {
                        viewModel.togglePasteSheet()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                }.padding(.bottom)
                VStack {
                    ForEach(Array(arrayLiteral: viewModel.paste), id:\.uid) { paste in
                        Button(action: {
                            viewModel.select(paste: paste)
                        }) {
                            VStack {
                                /*HStack {
                                    Image(systemName: "folder")
                                    Text(paste.title)
                                    Spacer()
                                    if (viewModel.states.paste.uid == paste.uid) {
                                        Image(systemName:"checkmark")
                                    }
                                }
                                .foregroundColor(Color(UIColor.navBarTitleColor))
                                Divider()*/
                            }
                        }.padding()
                    }
                }
            }
            .padding()
            .background(CornerShapeView(corners: [.topLeft,.topRight], radius: 30).foregroundColor(Color(UIColor.systemBackground)))
        }
        .navigationBarHidden(true)
        .alert(isPresented: viewModel.bindings.errorAlertIsShowing, content: {
            Alert(title: Text(viewModel.states.errorMessage), primaryButton: .default(Text(NSLocalizedString("yes", comment: "")), action: {
                viewModel.deleteIdea()
                callback?(nil)
                presentationMode.wrappedValue.dismiss()
            }), secondaryButton: .cancel(Text(NSLocalizedString("no", comment: ""))))
        })
    }
}

struct EditIdeaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditIdeaView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""), paste: .init(uid: "", title: "teu cu", icon: ""), idea: .T(uid: "", icon: "", tag: "", pasteUid: "", title: "", description: ""), callback: nil)
        }
    }
}
