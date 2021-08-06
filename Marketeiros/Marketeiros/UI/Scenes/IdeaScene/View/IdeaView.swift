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
        GridItem(.fixed(UIScreen.main.bounds.size.height * 0.2093),spacing: 15),
        GridItem(.fixed(UIScreen.main.bounds.size.height * 0.2093),spacing: 15)
    ]
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                Text(NSLocalizedString("collections", comment: ""))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("NavBarTitle"))
                
                if viewModel.states.pastes.isEmpty {
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                }
                
                ScrollView(.horizontal,showsIndicators: false){
                    LazyHStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                        Button(action: {
                            newPasteSheetIsShowing.toggle()
                        }) {
                            HStack{
                                Image(systemName: "folder")
                                    .foregroundColor(Color("FolderTextColor"))
                                Text(NSLocalizedString("btnCollection", comment: ""))
                                    .foregroundColor(Color("FolderTextColor"))
                                    .font(.callout)
                                    .fontWeight(.regular)
                            }
                            .padding()
                            .background(Color("IdeaViewColor"))
                            .cornerRadius(14)
                            .shadow(radius: 6, x: 2, y: 4)
                            
                            .padding(.trailing,5)
                            .padding(.vertical, 10)
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
                                    .shadow(radius: 6, x: 2, y: 4)
                                    .padding(.horizontal,5)
                                    .padding(.vertical, 10)
                                })
                        }
                    }).frame(height: 85)
                }
                Text(NSLocalizedString("ideaCard", comment: ""))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("NavBarTitle"))
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: layout, spacing: 0) {
                        NavigationLink(
                            destination: CreateIdeaSceneView(board: viewModel.board, pastes: viewModel.states.pastes, completion: nil),
                            label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color("IdeaViewColor"))
                                        .cornerRadius(22)
                                    VStack(spacing: 5) {
                                        Image(systemName: "sparkles.rectangle.stack.fill")
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.size.height * 0.0307, height: UIScreen.main.bounds.size.height * 0.0307, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(Color("NavBarTitle"))
                                        //                                                .frame(width: reader.size.width * 0.0826, height: reader.size.height * 0.0357, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        Text(NSLocalizedString("ideaBtn", comment: ""))
                                            .foregroundColor(Color("NavBarTitle"))
                                            .font(.body)
                                            .fontWeight(.regular)
                                    }
                                    .frame(width: UIScreen.main.bounds.size.width * 0.4293, height: UIScreen.main.bounds.size.width * 0.4293, alignment: .center)
                                    
                                }
                                .background(Color("IdeaViewColor"))
                                .cornerRadius(22)
                                .shadow(radius: 6, x: 2, y: 4)
                                
                                .padding(.vertical, 10)
                            })
                        ForEach(viewModel.states.ideas, id: \.uid) { idea in
                            NavigationLink(destination: EditIdeaView(board: viewModel.board, paste: viewModel.states.pastes.first(where: { paste in
                                paste.uid == idea.pasteUid
                            }) ?? Paste(uid: "none", title: "none", icon: "none"), idea: idea, callback: nil)) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color("IdeaViewColor"))
                                        .cornerRadius(22)
                                    VStack(spacing: 5) {
                                        HStack {
                                            Text(idea.title)
                                                .foregroundColor(Color("UserProfileColor"))
                                                .fontWeight(.semibold)
                                        }
                                    }
                                    .frame(width: UIScreen.main.bounds.size.width * 0.4293, height: UIScreen.main.bounds.size.width * 0.4293, alignment: .center)
                                    .background(Color("IdeaViewColor"))
                                    .cornerRadius(22)
                                }.shadow(radius: 6, x: 2, y: 4)
                                
                                .padding(.vertical, 10)
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: {
            viewModel.setListeners()
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
