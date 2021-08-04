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
    @StateObject var viewModel: InsideBoardViewModel
    @ObservedObject var vm: ViewModel
    @State var selectedIndex = 0
    @State var averageColorOn = false
    @State private var dragging: Post?
    @State var postsCount = 0
    
    init(board: Board) {  
        UIToolbar.appearance().barTintColor = UIColor.init(Color("ToolBarColor"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        
        _viewModel = StateObject(wrappedValue: InsideBoardViewModel(board: board))
        vm = ViewModel(igUser: (board.instagramAccount.count > 1) ? board.instagramAccount : "")
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
                HStack(){
                    Button(action: {
                        selectedIndex = 0
                    }, label: {
                        Text("Grid")
                            .font(.system(size: 20))
                            .foregroundColor((selectedIndex == 0) ? .white : Color(UIColor.unselectedColor))
                    })
                    .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                    .background((selectedIndex == 0) ? Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)).frame(width: reader.size.width/3) : Color(.clear).frame(width: reader.size.width/3))
                    .cornerRadius(13)
                    .frame(width: (reader.size.width/3) - 40)
                    Spacer()
                    Button(action: {
                        selectedIndex = 1
                    }, label: {
                        Text(NSLocalizedString("ideas", comment: ""))
                            .font(.system(size: 20))
                            .foregroundColor((selectedIndex == 1) ? .white : Color(UIColor.unselectedColor))
                    })
                    .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                    .background((selectedIndex == 1) ? Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)).frame(width: reader.size.width/3) : Color(.clear).frame(width: reader.size.width/3))
                    .cornerRadius(13)
                    .frame(width: (reader.size.width/3) - 40)
                    Spacer()
                    Button(action: {
                        selectedIndex = 2
                    }, label: {
                        Text("Mood")
                            .font(.system(size: 20))
                            .foregroundColor((selectedIndex == 2) ? .white : Color(UIColor.unselectedColor))
                    })
                    .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                    .background((selectedIndex == 2) ? Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)).frame(width: reader.size.width/3) : Color(.clear).frame(width: reader.size.width/3))
                    .cornerRadius(13)
                    .frame(width: (reader.size.width/3) - 40)
                   
                }.padding(.bottom,0)
               
                if viewModel.posts.count == 1 {
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                }

                if (selectedIndex == 0) {
                    ScrollView(){
                        LazyVGrid(columns: layout, spacing: 1) {
                            ForEach(viewModel.posts, id: \.uid) { post in
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
                                }.onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: post, listData: $viewModel.posts, current: $dragging))
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
                                    
                                    Button(action: {viewModel.toggleAddPostView()}){
                                        Rectangle()
                                            .foregroundColor(Color(UIColor.emptyCellGridColor))
                                            .frame(width: cellWidth,height: cellWidth, alignment: .center)
                                    }
                                        
                                }
                            }
                        }
                        
                        TestWebView(vm: vm)
                            .frame(width: 0, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                     }.animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: {
                                viewModel.toggleAddPostView()
                            }, label: {
                                Text(NSLocalizedString("newToolBar", comment: ""))
                            }).padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                self.averageColorOn.toggle()
                            }, label: {
                                Text(NSLocalizedString("colorsToolBar", comment: ""))
                                  
                            }).padding(.horizontal)
                        }
                    }
                } else if (selectedIndex == 1) {
                    IdeaView(viewModel: .init(board: viewModel.board))
                } else if (selectedIndex == 2) {
                    MoodBoardView()
                }
            }
            .sheet(isPresented: viewModel.bindings.editBoardIsShowing, content: {
                EditBoardView(board: viewModel.board) { board in
                    viewModel.change(board: board)
                }
            })
            .navigationBarItems(trailing:BoardMenuButton(editAction: {viewModel.toggleEditBoardSheet()}, deleteAction: {viewModel.deleteBoard { _ in
                presentationMode.wrappedValue.dismiss()
            }}))
            .navigationBarTitle(viewModel.board.title, displayMode: .inline)
            .padding(.init(top: 15, leading: 20, bottom: 0, trailing: 20))
            .onAppear {
                viewModel.getAllPosts()
            }
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
