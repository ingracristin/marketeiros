//
//  BoardView.swift
//  Marketeiros
//
//  Created by João Guilherme on 16/06/21.
//

import SwiftUI

struct AppButtonView: View {
    var label: String
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .foregroundColor(.white)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(5)
                .background(RoundedRectangle(cornerRadius: 10)
                                .accentColor(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1))))
        })
    }
}

struct BoardView: View {
    @ObservedObject var viewModel = BoardListViewModel()
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "cocon-bold", size: 34)!, .foregroundColor: UIColor(named: "NavBarTitle")!]
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            Image("headerBoard")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height * 0.27)
                .ignoresSafeArea()
            
            VStack(spacing:0) {
                HStack(alignment: .lastTextBaseline,spacing:0) {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .frame(height: 40)
                    }
                    .isHidden(true)
                }.padding(.bottom,0)
                    
                HStack {
                    Text("Home")
                        .navBarTitle()
                    Spacer()
                }
                .padding(.bottom,8)
                
                GeometryReader { reader in
                    ScrollView(.vertical) {
                        VStack(spacing: 20) {
                            HStack{
                                Text("Seus Quadros")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                    .foregroundColor(Color("NavBarTitle"))
                                Spacer()
                                AppButtonView(label: "Criar quadro") {
                                    viewModel.toggleSheetView()
                                }
                            }
                            
                            LazyVStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, pinnedViews: [], content: {
                                ForEach(viewModel.boards, id: \.uid) { board in
                                    NavigationLink(
                                        destination: InsideBoardView(board: board),
                                        label: {
                                            BoardCell(board: board)
                                                .frame(width: reader.size.width, height: reader.size.height * 0.2955, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(#colorLiteral(red: 0.8469843268, green: 0.8471066356, blue: 0.8469573855, alpha: 1)))
                                                .cornerRadius(20)
                                        })
                                }
                        
                            })
                            
                            HStack{
                                Text("Ideias")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                    .foregroundColor(Color("NavBarTitle"))
                                Spacer()
                                AppButtonView(label: "Criar Ideia") {
                                    viewModel.toggleSheetView()
                                }
                            }
                            
                            IdeaCell()
                                .frame(height: reader.size.height * 0.1380, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color(#colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)))
                                .cornerRadius(14)
                        }
                    }
                }
                .sheet(isPresented: viewModel.bindings.newBoardIsShowing, content: {
                    NewBoardSheet(callback: { board in
                        DispatchQueue.main.async {
                            viewModel.add(board: board)
                        }
                    })
                })
                .navigationBarHidden(true)
                .onAppear {
                    viewModel.getAllBoards()
                }
            }
            .padding(.horizontal,20)
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TabView {
                BoardView()
            }
        }
    }
}
