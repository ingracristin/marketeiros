//
//  PostsGridView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 20/07/21.
//
import UniformTypeIdentifiers
import Foundation
import SwiftUI

struct PostsGridView: View {
    @ObservedObject var viewModel: PostsGridViewModel
    @ObservedObject var vm: ViewModel
    @State var averageColorOn = false
    @State private var dragging: Post?
    
    init(board: Board) {
        viewModel = PostsGridViewModel(board: board)
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
            
            VStack {
                
                
                
                ScrollView(){
                    LazyVGrid(columns: layout, spacing: 1) {
                        ForEach(viewModel.posts.sorted {$0.dateOfCreation > $1.dateOfCreation}, id: \.uid) { post in
                            NavigationLink(destination: PostDetailsView(post: post,board: viewModel.board)) {
                                ZStack {
                                    FirebaseImage(post: post, board: viewModel.board,widthImg: cellWidth, heightImg: cellWidth, averageColorOn: $averageColorOn) {
                                        Rectangle()
                                            .foregroundColor(.gray)
                                        
                                    } image: {
                                        Image(uiImage: $0)
                                    }
                                    .frame(width: cellWidth, height: cellWidth, alignment: .center)
                                     .contextMenu {
                                          VStack{
                                                    Button(action:{}){
                                                        HStack{
                                                            Text(NSLocalizedString("share", comment: ""))
                                                            Image(systemName: "square.and.arrow.up")
                                                        }
                                                    }
    
                                                    Button(action:{}){
                                                        HStack{
                                                            Text(NSLocalizedString("delete", comment: ""))
                                                            Image(systemName: "trash")
                                                        }.foregroundColor(.red)
                                                    }
    
                                                }
                                            }
                                    
                                }
                                .onDrag({
                                    self.dragging = post
                                    return NSItemProvider(object: String(post.uid) as NSString)
                                })
                                .onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: post, listData: viewModel.posts, current: dragging))
                            }
                        }
                        
                        ForEach(vm.imagesUrls, id: \.id) { imageUrl in
                            AsyncImage(url: URL(string: imageUrl.imageUrl)!, averageColorOn: $averageColorOn) {
                                Rectangle()
                                    .foregroundColor(.gray)
                                
                            } image: {
                                Image(uiImage: $0)
                                    .resizable()
                            }
                            .frame(width: ((reader.size.width - 50) / 3),height: ((reader.size.width - 50) / 3), alignment: .center)
                        }
                        
                        if (vm.imagesUrls.count + viewModel.posts.count) < 18 {
                            ForEach(((vm.imagesUrls.count + viewModel.posts.count)..<18), id:\.self) {index in
                                Rectangle()
                                    .foregroundColor(Color(UIColor.emptyCellGridColor))
                                    .frame(width: ((reader.size.width - 50) / 3),height: ((reader.size.width - 50) / 3), alignment: .center)
                            }
                        }
                    }
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    TestWebView(vm: vm)
                        .frame(width: 0, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
           
             }.toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                        NavigationLink(destination: CreatePostUIView(board: viewModel.board)){
                            Image(systemName: "plus").foregroundColor(.black)
                        }
                    
                    
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
                }
            }
        }
        .onAppear {
            viewModel.getAllPosts()
        }
    }
}

//struct PostsGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostsGridView(board:  .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
//    }
//}
