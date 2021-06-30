//
//  BoardView.swift
//  Marketeiros
//
//  Created by João Guilherme on 16/06/21.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var viewModel = BoardListViewModel()
    
    var body: some View {
        GeometryReader{ reader in
            ScrollView(.vertical){
                VStack(spacing: 20){
                    HStack{
                        Text("Seus Quadros")
                            .fontWeight(.semibold)
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            viewModel.toggleSheetView()
                        }, label: {
                            Text("Criar quadro")
                                .foregroundColor(Color(#colorLiteral(red: 0.3960410953, green: 0.3961022794, blue: 0.3960276842, alpha: 1)))
                                .font(.caption)
                                .fontWeight(.semibold)
                            
                        }).frame(width: reader.size.width * 0.2125, height: reader.size.height * 0.0295, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                        .cornerRadius(12)
                    }
                    
                    LazyVStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, pinnedViews: [], content: {
                        ForEach(viewModel.boards, id: \.uid) { board in
                            NavigationLink(
                                destination: InsideBoardView(board: board),
                                label: {
                                    BoardCell(board: board)
                                        .frame(width: reader.size.width - 40, height: reader.size.height * 0.2955, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(#colorLiteral(red: 0.8469843268, green: 0.8471066356, blue: 0.8469573855, alpha: 1)))
                                        .cornerRadius(20)
                                })
                        }
                    })
                    
                    HStack{
                        Text("Ideias")
                            .fontWeight(.semibold)
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            viewModel.toggleSheetView()
                        }, label: {
                            Text("Criar quadro")
                                .foregroundColor(Color(#colorLiteral(red: 0.3960410953, green: 0.3961022794, blue: 0.3960276842, alpha: 1)))
                                .font(.caption)
                                .fontWeight(.semibold)
                            
                        })
                        .frame(width: reader.size.width * 0.2125, height: reader.size.height * 0.0295, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                        .cornerRadius(12)
                    }

                    IdeaCell()
                        .frame(width: reader.size.width - 40, height: reader.size.height * 0.1280, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(#colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)))
                        .cornerRadius(14)
                }
            }
            .padding(.horizontal,20)
        }.sheet(isPresented: viewModel.bindings.newBoardIsShowing, content: {
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
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
