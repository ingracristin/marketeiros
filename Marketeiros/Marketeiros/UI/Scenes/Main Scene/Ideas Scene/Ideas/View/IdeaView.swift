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
    @State var sort: String = ""
    //@State var filteredIdeas = [Idea]()
    
    let layout = [
        GridItem(.fixed(UIScreen.main.bounds.size.height * 0.2093),spacing: 5),
        GridItem(.fixed(UIScreen.main.bounds.size.height * 0.2093),spacing: 5)
    ]
    
    var body: some View {
        ZStack(){
            if(viewModel.states.ideas.isEmpty){
                Image("BgIdea")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.size.width)
                    .aspectRatio(contentMode: .fit)
            }
        
            GeometryReader { reader in
                VStack(alignment: .leading) {
                    HStack(){
                        Text(NSLocalizedString("ideaCard", comment: ""))
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("NavBarTitle"))
                            .padding(.horizontal, 20)
                        Spacer()
                        Menu {
                            Picker(selection: $sort, label: Text("Sorting options")) {
                                
                                Text("Todos os cartões").tag("todos")
                                ForEach(viewModel.states.pastes, id: \.uid) { paste in
                                    Text(paste.title).tag(paste.title)
                                }
                                Text("Criar filtro").tag("criar")
                            }
                        }
                        label: {
                            Label {
                                Text("")
                                    
                            } icon: {
                                Image(systemName: "slider.horizontal.3")
                                     .resizable()
                                     .frame(width: 22, height: 22)
                                     .foregroundColor(Color("NavBarTitle"))
                                     .padding()
                            }
                        }
                    }
                    
                    if(viewModel.states.ideas.isEmpty){
                        VStack(){
                            Spacer()
                            HStack(){
                                Spacer()
                                NavigationLink(
                                    destination: CreateIdeaSceneView(board: viewModel.board, pastes: viewModel.states.pastes, completion: nil),
                                    label: {
                                        ZStack {
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
        //                                    .frame(width: UIScreen.main.bounds.size.width * 0.4293, height: UIScreen.main.bounds.size.width * 0.4293, alignment: .center)
                                            
                                        }
                                        .padding(.horizontal, 40)
                                        .padding(.vertical, 60)
                                        .background(Color("IdeaViewColor"))
                                        .cornerRadius(22)
                                        .shadow(radius: 6, x: 2, y: 4)
                                        
                                    })
                               
                                Spacer()
                            }
                            
                            Text(NSLocalizedString("noIdea", comment: ""))
                                .font(Font.custom("cocon-bold",size: 24))
                                .bold()
                                //.fixedSize(horizontal: false, vertical: true)
                                .lineLimit(nil)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal,50)
                                .foregroundColor(Color("NavBarTitle"))
                                .padding(.top,10)
                            Text(NSLocalizedString("createIdeaClik", comment: ""))
                                .foregroundColor(Color("NavBarTitle"))
                            Spacer()
                            Spacer()
                        }

                    }else{
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
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                    })
                                ForEach(viewModel.states.filteredIdeas, id: \.uid) { idea in
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
                                        .padding(.horizontal)
                                        .padding(.vertical, 10)
                                    }
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
            .onChange(of: sort) { _ in
                if (sort == "criar") {
                    sort = ""
                    newPasteSheetIsShowing.toggle()
                } else if(sort == "todos") {
                    viewModel.resetFilter()
                } else if(sort != "") {
                    viewModel.filterIdeas(by: sort)
                }
            }
        }
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
