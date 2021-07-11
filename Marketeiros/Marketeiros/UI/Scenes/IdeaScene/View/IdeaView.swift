//
//  SceneView.swift
//  Marketeiros
//
//  Created by João Guilherme on 29/06/21.
//

import SwiftUI

struct IdeaView: View {
    @StateObject var viewModel: IdeaViewModel
    @State var newPasteSheetIsShowing = false
        
    let layout = [
        GridItem(.fixed(170),spacing: 15),
        GridItem(.fixed(170),spacing: 15)
    ]
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                Text("Pastas")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("NavBarTitle"))
                
                if viewModel.states.pastes.isEmpty {
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                }
                
                ScrollView(.horizontal){
                    LazyHStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                        Button(action: {
                            newPasteSheetIsShowing.toggle()
                        }) {
                            HStack{
                                Image(systemName: "folder")
                                    .foregroundColor(Color("FolderTextColor"))
                                Text("Nova pasta")
                                    .foregroundColor(Color("FolderTextColor"))
                                    .font(.callout)
                                    .fontWeight(.regular)
                            }
                            .padding()
                            .background(Color("IdeaViewColor"))
                            .cornerRadius(14)
                            //.frame(width:UIScreen.main.bounds.size.width * 0.2933, height: UIScreen.main.bounds.size.height * 0.0566)
                        }
//                        .frame(width: reader.size.width * 0.2933, height: reader.size.height * 0.0566, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        ForEach(viewModel.states.pastes, id: \.uid) { paste in
                            NavigationLink(
                                destination: PastesDetailsView(paste: paste, board: viewModel.board, ideas: viewModel.getIdeasOfSelectedPaste(paste: paste)),
                                label: {
                                    
                                        HStack(){
                                            Image(systemName: "folder")
                                                .foregroundColor(Color("FolderTextColor"))
                                            Text(paste.title)
                                                .foregroundColor(Color("FolderTextColor"))
                                                .font(.callout)
                                                .fontWeight(.regular)
                                        }
                                        .padding()
                                        .background(Color("IdeaViewColor"))
                                        .cornerRadius(14)
                                    
                                })
                        }
                    }).frame(height: 70)
                }
                //.fixedSize()
                Text("Cartões de ideias")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("NavBarTitle"))
                
                ScrollView() {
                    LazyVGrid(columns: layout, spacing: 15) {
                        NavigationLink(
                            destination: CreateIdeaSceneView(board: viewModel.board, pastes: viewModel.states.pastes),
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
                                        Text("Adicionar ideia")
                                            .foregroundColor(Color("NavBarTitle"))
                                            .font(.body)
                                            .fontWeight(.regular)
                                    }
                                    .frame(width: UIScreen.main.bounds.size.width * 0.4293, height: UIScreen.main.bounds.size.width * 0.4293, alignment: .center)
                                }
                                .background(Color("IdeaViewColor"))
                                .cornerRadius(22)
                        })
                        ForEach(viewModel.states.ideas, id: \.uid) { idea in
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color("IdeaViewColor"))
                                    .cornerRadius(22)
                                VStack(spacing: 5) {
                                    Text(idea.title)
                                        .foregroundColor(Color("UserProfileColor"))
                                        
                                        .fontWeight(.semibold)
                                }
                                .frame(width: UIScreen.main.bounds.size.width * 0.4293, height: UIScreen.main.bounds.size.width * 0.4293, alignment: .center)
                                .background(Color("IdeaViewColor"))
                                .cornerRadius(22)
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: {
            viewModel.loadData()
        })
        .sheet(isPresented: $newPasteSheetIsShowing, content: {
            CreatePasteView(board: viewModel.board)
        })
    }
}

struct SceneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TabView {
                IdeaView(viewModel: .init(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: "")))
                    .padding()
            }
        }
    }
}
