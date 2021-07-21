//
//  InsideBoardView.swift
//  Marketeiros
//
//  Created by João Guilherme on 24/06/21.
//hm

import SwiftUI
import UniformTypeIdentifiers

struct InsideBoardView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: InsideBoardViewModel
    @ObservedObject var vm: ViewModel
    @State var selectedView = 0
    @State var averageColorOn = false
    @State private var dragging: Post?
    @State var postsCount = 0
    
    init(board: Board) {
        UIToolbar.appearance().barTintColor = UIColor.init(Color(#colorLiteral(red: 0.9798186421, green: 0.9811866879, blue: 0.9327015281, alpha: 1)))

        viewModel = InsideBoardViewModel(board: board)
        vm = ViewModel(igUser: (board.instagramAccount.count > 1) ? board.instagramAccount : "ingracristin")
    }
    
    var body: some View {
        GeometryReader() { reader in
            let cellWidth: CGFloat = (reader.size.width - 50) / 3
                        
            let layout = [
                GridItem(.fixed(cellWidth), spacing: 1),
                GridItem(.fixed(cellWidth), spacing: 1),
                GridItem(.fixed(cellWidth), spacing: 1),
            ]
            
            NavigationLink(destination: CreatePostUIView(board: viewModel.board), isActive: viewModel.bindings.addPostScreenShowing){
                EmptyView()
            }
            
            VStack(spacing: 20) {
                Picker("View", selection: $selectedView, content: {
                    Text("Grid").tag(0)
                    Text(NSLocalizedString("ideas", comment: "")).tag(1)
                    Text("Mood").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                
                if viewModel.posts.count == 1 {
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                }

                if (selectedView == 0) {
                    ScrollView(){
                        LazyVGrid(columns: layout, spacing: 1) {
                            ForEach(viewModel.posts.sorted {$0.dateOfCreation > $1.dateOfCreation}, id: \.uid) { post in
                                NavigationLink(destination: PostDetailsView(post: post,board: viewModel.board)) {
                                    PostsGridCellView(
                                        post: post,
                                        board: viewModel.board,
                                        height: cellWidth,
                                        width: cellWidth,
                                        averageColorOn: $averageColorOn)
                                    .onDrag({
                                        self.dragging = post
                                        return NSItemProvider(object: String(post.uid) as NSString)
                                    })
                                    .onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: post, listData: viewModel.posts, current: dragging))
                                }
                            }
                            
                            ForEach(vm.imagesUrls, id: \.id) { imageUrl in
                                
                                AsyncImage(url: URL(string: imageUrl.imageUrl)!, averageColorOn: $averageColorOn, height: cellWidth, width: cellWidth) {
                                        Rectangle()
                                            .foregroundColor(Color(UIColor.emptyCellGridColor))
                                        
                                    } image: {
                                        Image(uiImage: $0)
                                            .resizable()
                                    }
                                    .frame(width: cellWidth,height: cellWidth, alignment: .center)
                                 
                            }
                            
                            if (vm.imagesUrls.count + viewModel.posts.count) < 18 {
                                ForEach(((vm.imagesUrls.count + viewModel.posts.count)..<18), id:\.self) {index in
                                    Rectangle()
                                        .foregroundColor(Color(UIColor.emptyCellGridColor))
                                        .frame(width: cellWidth,height: cellWidth, alignment: .center)
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
                                Text("Novo")
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                self.averageColorOn.toggle()
                            }, label: {
                                Text("Cores")
                            })
                            
                            Spacer()
                            
                            
                            Button(action: {}, label: {
                                Text("Formato")
                                    
                            })
                            
                           
                        }
                    }
                } else if (selectedView == 1) {
                    IdeaView(viewModel: .init(board: viewModel.board))
                } else if (selectedView == 2) {
                    MoodBoardView()
                }
            }
            .navigationBarTitle(viewModel.board.title, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {}, label: {
                Text("...")
            }))
            .onAppear {
                viewModel.getAllPosts()
            }
            .padding(.init(top: 15, leading: 20, bottom: 0, trailing: 20))
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
