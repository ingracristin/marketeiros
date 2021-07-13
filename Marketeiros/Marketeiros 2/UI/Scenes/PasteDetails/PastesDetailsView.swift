//
//  PastesDetailsView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 08/07/21.
//

import SwiftUI

struct PastesDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PasteDetailsViewModel
    
    let layout = [
        GridItem(.fixed(170),spacing: 15),
        GridItem(.fixed(170),spacing: 15)
    ]
    
    init(paste: Paste, board: Board, ideas: [Idea]) {
        viewModel = PasteDetailsViewModel(paste: paste,board: board,ideas: ideas)
    }
    
    var body: some View {
        if viewModel.ideas.isEmpty {
            VStack {
                Spacer()
                NavigationLink(
                    destination: CreateIdeaSceneView(board: viewModel.board, pastes: [viewModel.paste]) { idea in
                        viewModel.ideas.append(idea)
                    },
                    label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color("IdeaViewColor"))
                                .cornerRadius(22)
                            VStack(spacing: 5) {
                                Image(systemName: "sparkles.rectangle.stack.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color("NavBarTitle"))
    //                                                .frame(width: reader.size.width * 0.0826, height: reader.size.height * 0.0357, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                Text("Adicionar idéia")
                                    .foregroundColor(Color("NavBarTitle"))
                                    .font(.body)
                                    .fontWeight(.regular)
                            }
                        }
                        .background(Color("IdeaViewColor"))
                        .cornerRadius(22)
                })
                    .frame(width: 200, height: 200)
                Spacer()
            }.navigationBarTitle(viewModel.paste.title, displayMode: .inline)
        } else {
            ScrollView() {
                LazyVGrid(columns: layout, spacing: 15) {
                    ForEach(0..<viewModel.ideas.count, id: \.self) { index in
                        NavigationLink(
                            destination: EditIdeaView(board: viewModel.board, paste: viewModel.paste, idea: viewModel.ideas[index],callback: { idea in
                                if let idea = idea {
                                    self.viewModel.ideas[index] = idea
                                } else {
                                    self.viewModel.ideas.remove(at: index)
                                }
                            }),
                            label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color("IdeaViewColor"))
                                        .cornerRadius(22)
                                    VStack(spacing: 5) {
                                        Text(viewModel.ideas[index].title)
                                            .foregroundColor(Color("UserProfileColor"))
                                            .fontWeight(.semibold)
                                    }
                                    .frame(width: 170, height: 170, alignment: .center)
                                    
                                }
                                .background(Color("IdeaViewColor"))
                                .cornerRadius(22)
                        })
                    }
                }
            }
            .navigationBarTitle(viewModel.paste.title, displayMode: .inline)
            .navigationBarItems(
                trailing: Menu(content: {
                    Button {
                        viewModel.deletePaste(completion: { _ in
                            presentationMode.wrappedValue.dismiss()
                        })
                    } label: {
                        Label("Deletar", systemImage: "trash")
                    }

                    Button {
                        viewModel.toggleSheet()
                    } label: {
                        Label("Editar", systemImage: "pencil")
                    }
                }, label: {
                    Image(systemName: "ellipsis.circle")
                }))
            .sheet(isPresented: viewModel.bindings.sheetViewIsAppearing, content: {
                EditPasteView(currentPaste: viewModel.paste, board: viewModel.board) { paste in
                    viewModel.set(paste: paste)
                }
            })
        }
    }
}

struct PastesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PastesDetailsView(paste: .init(uid: "", title: "", icon: ""), board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""),ideas: [])
    }
}
