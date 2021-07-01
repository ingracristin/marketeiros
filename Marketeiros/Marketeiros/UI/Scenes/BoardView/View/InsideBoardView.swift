//
//  InsideBoardView.swift
//  Marketeiros
//
//  Created by João Guilherme on 24/06/21.
//

import SwiftUI

struct InsideBoardView: View {
    @State var selectedView = 0
    @State var eita = false
    @State var averageColorOn = false
    @ObservedObject var viewModel: InsideBoardViewModel
    
    init(board: Board) {
        viewModel = InsideBoardViewModel(board: board)
    }
    
    let layout = [
        GridItem(.flexible(),spacing: 2),
        GridItem(.flexible(),spacing: 2),
        GridItem(.flexible(),spacing: 2)
    ]
    
    var body: some View {
        GeometryReader(){ reader in
            NavigationLink(destination: CreatePostUIView(board: viewModel.board), isActive: $eita) {
                EmptyView()
            }
            VStack(spacing: 20){
                Picker("View", selection: $selectedView, content: {
                    Text("Grid").tag(0)
                    Text("Ideias").tag(1)
                    Text("Painel").tag(2)
                })
                .pickerStyle(SegmentedPickerStyle())
                
                ScrollView(){
                    LazyVGrid(columns: layout, spacing: 2){
                        ForEach(1...18, id: \.self){ _ in
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color(#colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253800511, alpha: 1)))
                                Image("test")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Rectangle()
                                    .foregroundColor(Color(UIImage(named:"test")?.averageColor ?? .clear)).opacity(0.7).isHidden(!averageColorOn)
                            }.frame(width: ((reader.size.width - 21)/3) - 2.0,height:((reader.size.width - 21)/3) - 2.0)
                            
                        }
                    }
                }
            }.padding(.horizontal,20)
        }
        .navigationTitle(viewModel.board.title)
        .toolbar{
            ToolbarItemGroup(placement: .bottomBar){
                Button(action: {
                    eita.toggle()
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
            viewModel.setListenerOnPosts()
        }
    }
}

struct InsideBoardView_Previews: PreviewProvider {
    static var previews: some View {
        InsideBoardView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
    }
}
