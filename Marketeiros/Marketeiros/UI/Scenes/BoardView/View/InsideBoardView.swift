//
//  InsideBoardView.swift
//  Marketeiros
//
//  Created by João Guilherme on 24/06/21.
//

import SwiftUI

struct InsideBoardView: View {
    @State var selectedView = 0
    @State var averageColorOn = false
    @ObservedObject var viewModel: InsideBoardViewModel
    
    init(board: Board) {
        viewModel = InsideBoardViewModel(board: board)
    }
    
    let layout = [
        GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))
    ]
    let moodLayout = [
        GridItem(.flexible(),spacing: 0.5),
        GridItem(.flexible(),spacing: 0.5)
    ]
    let moodLayou = [
        GridItem(.flexible(),spacing: 1)
    ]
    
    var body: some View {
        GeometryReader() { reader in
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
                
                ScrollView(){
                    LazyVGrid(columns: layout, spacing: 2) {
                    if (selectedView == 0){
                        ForEach(viewModel.posts, id: \.uid) { post in
                            NavigationLink(destination: PostDetailsView(post: post,board: viewModel.board)) {
                                ZStack {
                                    FirebaseImage(post: post, board: viewModel.board, averageColorOn: $averageColorOn) {
                                        RoundedRectangle(cornerRadius: 25)
                                            .foregroundColor(.gray)
                                    } image: {
                                        Image(uiImage: $0)
                                                                            
                                    }
                                    .frame(width: 100, height: 100, alignment: .center)
                                    
                                }
                            }
                        }
                    } else if (selectedView == 1) {
                        ForEach(1...9, id: \.self){ index in
                            if (index % 2 == 0){
                                LazyVGrid(columns: moodLayou, spacing: 15) {
                                    Rectangle()
                                        .foregroundColor(Color(#colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253800511, alpha: 1)))
                                        .frame(width: 340, height: 195)
                                        .cornerRadius(15)
                                }
                            } else {
                                LazyVGrid(columns: moodLayout, spacing: 10) {
                                    ForEach(1...2, id: \.self){ _ in
                                        Rectangle()
                                            .foregroundColor(Color(#colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253800511, alpha: 1)))
                                            .frame(width: 150, height: 195)
                                            .cornerRadius(15)
                                    }
                                }
                                
                            }
                        }
                    }
                }
                }//.padding(.horizontal,20)
            }
            .navigationTitle(viewModel.board.title)
            .toolbar {
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
                    
                    Button(action: {}, label: {
                        Image(systemName: "trash").foregroundColor(.black)
                    })
                }
            }.onAppear {
                viewModel.getAllPosts()
            }
            .padding(.horizontal,20)
        }
    }
}


struct InsideBoardView_Previews: PreviewProvider {
    static var previews: some View {
        InsideBoardView(board: .init(uid: "ingracristin", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
    }
}
