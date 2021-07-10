//
//  InsideBoardView.swift
//  Marketeiros
//
//  Created by João Guilherme on 24/06/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct InsideBoardView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: InsideBoardViewModel
    @ObservedObject var vm = ViewModel()
    @State var selectedView = 0
    @State var averageColorOn = false
    @State private var dragging: Post?
    @State var postsCount = 0
    
    init(board: Board) {
        viewModel = InsideBoardViewModel(board: board)
    }
    
    let moodLayout = [
        GridItem(.flexible(),spacing: 0.5),
        GridItem(.flexible(),spacing: 0.5)
    ]
    let moodLayou = [
        GridItem(.flexible(),spacing: 1)
    ]
    
    var body: some View {
        GeometryReader() { reader in
            let layout = [
                GridItem(.fixed(((reader.size.width - 50) / 3))),
                GridItem(.fixed(((reader.size.width - 50) / 3))),
                GridItem(.fixed(((reader.size.width - 50) / 3))),
            ]
            
            NavigationLink(destination: CreatePostUIView(board: viewModel.board), isActive: viewModel.bindings.addPostScreenShowing){
                EmptyView()
            }
            
            VStack(spacing: 20) {
                Picker("View", selection: $selectedView, content: {
                    Text("Grid").tag(0)
                    Text("Ideias").tag(1)
                    Text("Painel").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
                
                if (selectedView == 0) {
                    ScrollView(){
                        LazyVGrid(columns: layout, spacing: 1) {
                            ForEach(viewModel.posts, id: \.uid) { post in
                                NavigationLink(destination: PostDetailsView(post: post,board: viewModel.board)) {
                                    ZStack {
                                        FirebaseImage(post: post, board: viewModel.board,widthImg:((reader.size.width - 50) / 3),heightImg:((reader.size.width - 50) / 3), averageColorOn: $averageColorOn) {
                                            Rectangle()
                                                .foregroundColor(.gray)
                                        } image: {
                                            Image(uiImage: $0)
                                        }
                                        .frame(width: ((reader.size.width - 50) / 3),height: ((reader.size.width - 50) / 3), alignment: .center)
                                        
                                    }.onDrag({
                                        self.dragging = post
                                        return NSItemProvider(object: String(post.uid) as NSString)
                                    })
                                    .onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: post, listData: viewModel.posts, current: dragging))
                                }
                            }
                            
                            ForEach(vm.imagesUrls, id: \.self) { url in
                                AsyncImage(url: URL(string: url)!) {
                                    Rectangle()
                                        .foregroundColor(.gray)
                                } image: {
                                    Image(uiImage: $0)
                                        .resizable()
                                }
                                .frame(width: ((reader.size.width - 50) / 3),height: ((reader.size.width - 50) / 3), alignment: .center)
                            }
                            
                            if (vm.imagesUrls.count + viewModel.posts.count) < 18 {
                                ForEach(((vm.imagesUrls.count + viewModel.posts.count)..<19), id:\.self) {index in
                                    Rectangle()
                                        .foregroundColor(Color(UIColor.emptyCellGridColor))
                                        .frame(width: ((reader.size.width - 50) / 3),height: ((reader.size.width - 50) / 3), alignment: .center)
                                }
                            }
                        }
                        
                        TestWebView(vm: vm)
                            .frame(width: 0, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                     }.toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: {
                                viewModel.toggleAddPostView()
                            }, label: {
                                Image(systemName: "plus").foregroundColor(.black)
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                self.averageColorOn.toggle()
                            }, label: {
                                Image(systemName: "paintpalette").foregroundColor(.black)
                            })
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(systemName: "repeat").foregroundColor(.black)
                            })
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(systemName: "squareshape.split.3x3").foregroundColor(.black)
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.deleteBoard { result in
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }, label: {
                                Image(systemName: "trash").foregroundColor(.black)
                            })
                        }
                    }
                } else if (selectedView == 1) {
                    IdeaView(viewModel: .init(board: viewModel.board))
                } else if (selectedView == 2) {
                    MoodBoardView()
                }
            }
            .navigationTitle(viewModel.board.title)
            .onAppear {
                viewModel.getAllPosts()
            }
            .padding(.horizontal,20)
        }
    }
}

struct InsideBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InsideBoardView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
        }
    }
}
