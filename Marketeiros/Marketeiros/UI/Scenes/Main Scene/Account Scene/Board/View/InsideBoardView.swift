
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
    @State var selectedIndex = 0
    @State var averageColorOn = false
    @State private var dragging: Post?
    @State var offset: CGFloat = 0
    @State var isCollpsed: Bool = true
    var firstPhoto = true
    
    func toggleBottomSheet() {
        withAnimation {
            offset = isCollpsed ? 500 : 0
            isCollpsed.toggle()
        }
    }
    
    init(changesCallback: @escaping (Board) -> ()) {
        _viewModel = StateObject(wrappedValue: InsideBoardViewModel(changesCallback: changesCallback))
    }
    
    var body: some View {
        BottomSheetView(offset: $offset, isCollpsed: $isCollpsed) {
            GeometryReader() { reader in
                let cellWidth: CGFloat = ((reader.size.width) / 3) - 1
                            
                let layout = [
                    GridItem(.fixed(cellWidth), spacing: 1),
                    GridItem(.fixed(cellWidth), spacing: 1),
                    GridItem(.fixed(cellWidth), spacing: 1),
                ]
                
                NavigationLink(destination: CreatePostUIView(board: viewModel.states.board), isActive: viewModel.bindings.addPostScreenShowing){
                    EmptyView()
                }
                
                NavigationLink(
                    destination:
                        SharePostView(scheduledNotification: UserNotificationService.shared.bindings.scheduledNotification)
                        .navigationBarHidden(true),
                    isActive: UserNotificationService.shared.bindings.hasNotification,
                    label: {
                        EmptyView()
                    })
                
                VStack(spacing: 10) {
                    HStack{
                        Text(viewModel.screenNavTitle)
                            .font(Font.custom("cocon-bold",size: 24))
                            .bold()
                            .foregroundColor(Color("NavBarTitle"))
                        Spacer()
                        BoardImageView(board: viewModel.bindings.board)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical,30)
                    .onTapGesture {
                        toggleBottomSheet()
                    }
                    
                    //Spacer()
                    ZStack {
                        HStack {
                            Button(action: {
                                selectedIndex = 0
                            }, label: {
                                Text("Grid")
                                    .font(Font.custom("cocon-bold",size: 18))
                                    .bold()
                                    .foregroundColor((selectedIndex == 0) ? .white : Color(UIColor.unselectedColor))
                                    .fixedSize(horizontal: false, vertical: true)
                            })
                            .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                            .background((selectedIndex == 0) ? Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)).frame(width: reader.size.width/3) : Color(.clear).frame(width: reader.size.width/3))
                            .cornerRadius(13)
                            Spacer()
                        }
                        Button(action: {
                            selectedIndex = 1
                        }, label: {
                            Text(NSLocalizedString("calendar", comment: ""))
                                .font(Font.custom("cocon-bold",size: 18))
                                .bold()
                                .foregroundColor((selectedIndex == 1) ? .white : Color(UIColor.unselectedColor))
                                .fixedSize(horizontal: false, vertical: true)
                        })
                        .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                        .background((selectedIndex == 1) ? Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)).frame(width: reader.size.width/3) : Color(.clear).frame(width: reader.size.width/3))
                        .cornerRadius(13)
                        HStack {
                            Spacer()
                            Button(action: {
                              selectedIndex = 2
                            }, label: {
                                Text(NSLocalizedString("ideas", comment: ""))
                                    .font(Font.custom("cocon-bold",size: 18))
                                    .bold()
                                    .foregroundColor((selectedIndex == 2) ? .white : Color(UIColor.unselectedColor))
                                    .fixedSize(horizontal: false, vertical: true)
                            })
                            .padding(.init(top: 1, leading: 12, bottom: 1, trailing: 12))
                            .background((selectedIndex == 2) ? Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)).frame(width: reader.size.width/3) : Color(.clear).frame(width: reader.size.width/3))
                            .cornerRadius(13)
                        }
                    }
                    .padding(.bottom,0)
                    .padding(.horizontal)
                    
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                
                    if (selectedIndex == 0) {
                        ZStack {
                        ScrollView(){
                            LazyVGrid(columns: layout, spacing: 1) {
                                ForEach(viewModel.posts, id: \.uid) { post in
                                    NavigationLink(destination: PostDetailsView(post: post,board: viewModel.states.board)) {
                                        PostsGridCellView(
                                            post: post,
                                            board: viewModel.states.board,
                                            height: cellWidth,
                                            width: cellWidth,
                                            averageColorOn: $averageColorOn)
                                            .onDrag({
                                                self.dragging = post
                                                return NSItemProvider(object: String(post.uid) as NSString)
                                            })
                                    }.onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: post, listData: $viewModel.posts, current: $dragging))
                                }
                                
                                ForEach(viewModel.states.imagesUrls, id: \.id) { imageUrl in
                                    AsyncImage(url: URL(string: imageUrl.imageUrl)!, averageColorOn: $averageColorOn, height: cellWidth, width: cellWidth) {
                                            Rectangle()
                                                .foregroundColor(Color(UIColor.emptyCellGridColor))
                                        } image: {
                                            Image(uiImage: $0)
                                                .resizable()
                                        }
                                        .frame(width: cellWidth,height: cellWidth, alignment: .center)
                                }
                                if (viewModel.states.imagesUrls.count + viewModel.posts.count) < 15 {
                                    ForEach(((viewModel.states.imagesUrls.count + viewModel.posts.count)..<15), id:\.self) {index in
                                        
                                        Button(action: {viewModel.toggleAddPostView()}){
                                            Rectangle()
                                                .foregroundColor(Color(UIColor.emptyCellGridColor))
                                                .frame(width: cellWidth,height: cellWidth, alignment: .center)
                                        }
                                    }
                                }
                            }.animation(.linear)
                            
                            IgWebView(igUser: viewModel.bindings.igAccount, imagesUrls: viewModel.bindings.imagesUrls)
                                .frame(width: 0, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }.loadingView(text: .constant("aaaaa"), isPresenting: viewModel.bindings.emptyProfile, alert: EmptyProfileAlert(isShowing: viewModel.bindings.emptyProfile))
                            
                        VStack(spacing:0){
                            Spacer()
                            HStack {
                                Button(action: {
                                    viewModel.toggleAddPostView()
                                }, label: {
                                    Text(NSLocalizedString("newToolBar", comment: ""))
                                        .foregroundColor(Color("ToolBarButtonsColor"))
                                })
                                
                                Spacer()
                                
                                Button(action: {
                                    self.averageColorOn.toggle()
                                }, label: {
                                    Text(NSLocalizedString("colorsToolBar", comment: ""))
                                        .foregroundColor(Color("ToolBarButtonsColor"))
                                })
                            }
                            .padding(.horizontal,20)
                            .padding(.bottom, 40)
                            .padding(.top,20)
                            .background(Color("ToolBarColor"))
                        }
                    }
                    //.animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                        
                    } else if (selectedIndex == 1) {
                        CalendarPageView(board: viewModel.bindings.board)
                           // .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)

                    } else if (selectedIndex == 2) {
                        IdeaView(viewModel: .init(board: viewModel.states.board))
                       // .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                    }
                }
//                .sheet(isPresented: viewModel.bindings.editBoardIsShowing, content: {
//                    EditBoardView(board: viewModel.states.board) { board in
//                        viewModel.change(board: board)
//                    }
//                })
                .navigationBarHidden(true)
                .onAppear {
                    viewModel.loadUserData()
                }
                .alert(isPresented: viewModel.bindings.errorAlertIsShowing, content: {
                    Alert(title: Text(viewModel.states.errorMessage), primaryButton: .default(Text(NSLocalizedString("yes", comment: "")), action: {
    //                    viewModel.deleteBoard { _ in
    //                        presentationMode.wrappedValue.dismiss()
    //                    }
                    }), secondaryButton: .cancel(Text(NSLocalizedString("no", comment: ""))))
                })
            }
        } sheet: {
            ProfileSheet(boards: viewModel.bindings.boards, board: viewModel.bindings.board, okButtonCallback: {toggleBottomSheet()}).environmentObject(viewModel)
        }
        .loadingView(text: .constant("aaaaa"), isPresenting: viewModel.bindings.isLoading, alert: LoadingPhotosView(isShowing: viewModel.bindings.isLoading))
    }
}

struct InsideBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InsideBoardView(changesCallback: {b in})
        }
    }
}
