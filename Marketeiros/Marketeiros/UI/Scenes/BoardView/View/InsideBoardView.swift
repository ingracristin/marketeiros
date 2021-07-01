//
//  InsideBoardView.swift
//  Marketeiros
//
//  Created by João Guilherme on 24/06/21.
//

import SwiftUI

struct InsideBoardView: View {
    @State var selectedView = 1
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
    let moodLayout = [
        GridItem(.flexible(),spacing: 0.5),
        GridItem(.flexible(),spacing: 0.5)
    ]
    let moodLayou = [
        GridItem(.flexible(),spacing: 1)
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
<<<<<<< HEAD
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
=======
                    if(selectedView == 0){
                        LazyVGrid(columns: layout, spacing: 1){
                            ForEach(1...18, id: \.self){ _ in
                                Rectangle()
                                    .frame(height:reader.size.height * 0.15)
                                    .foregroundColor(Color(#colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253800511, alpha: 1)))
                            }
                        }
                    }else if(selectedView == 1){
                        ForEach(1...9, id: \.self){ index in
                            
                                if(index % 2 == 0){
                                    LazyVGrid(columns: moodLayou, spacing: 15){
                                        Rectangle()
                                            .foregroundColor(Color(#colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253800511, alpha: 1)))
                                            .frame(width: 340, height: 195)
                                            .cornerRadius(15)
                                        
                                    }
                                }else{
                                    LazyVGrid(columns: moodLayout, spacing: 10){
                                        ForEach(1...2, id: \.self){ _ in
                                            Rectangle()
                                                .foregroundColor(Color(#colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253800511, alpha: 1)))
                                                .frame(width: 150, height: 195)
                                                .cornerRadius(15)
                                        }
                                    }
                                    
                                }
>>>>>>> main
                            
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
        InsideBoardView(board: .init(uid: "ingracristin", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
    }
}
