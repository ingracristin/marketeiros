//
//  BoardCell.swift
//  Marketeiros
//
//  Created by João Guilherme on 16/06/21.
//

import SwiftUI

struct BoardCell: View {
    let board : Board
    @State var average = false
    @Binding var reload: Bool
    var body: some View {
        GeometryReader() { reader in
            ZStack(alignment: .bottomLeading) {
                if reload {
                    FirebaseImage(board: board, averageColorOn: $average, widthImg: reader.size.width, heightImg: reader.size.height) {
                        Image("bgBoardCell")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .frame(width: reader.size.width, height: reader.size.height,alignment: .center)
                        
                        VStack(){
                            HStack(){
                                Spacer()
                                Menu {
                                    Button(NSLocalizedString("edit board", comment: ""), action: {
                                        
                                    })
                                    
                                } label: {
                                    Text("...")
                                        .fontWeight(.bold)
                                        .font(.title)
                                }.foregroundColor(Color("navbarColor"))
                            }.padding(.trailing,20)
                            Spacer()
                        }.padding(.leading)
                    }
                } else {
                    FirebaseImage(board: board, averageColorOn: $average, widthImg: reader.size.width, heightImg: reader.size.height) {
                        Image("bgBoardCell")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .frame(width: reader.size.width, height: reader.size.height,alignment: .center)
                        
                        VStack(){
                            HStack(){
                                Spacer()
                                Menu {
                                    Button(NSLocalizedString("edit board", comment: ""), action: {
                                        
                                    })
                                    
                                } label: {
                                    Text("...")
                                        .fontWeight(.bold)
                                        .font(.title)
                                }.foregroundColor(Color("navbarColor"))
                            }.padding(.trailing,20)
                            Spacer()
                        }.padding(.leading)
                    }
                }
                
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9333333333, alpha: 1)))
                    .opacity(0.7)
                    .frame(height: reader.size.height * 0.3333)
                
                VStack(alignment: .leading){
                    Text(board.title)
                        .foregroundColor(Color(#colorLiteral(red: 0.1921568627, green: 0.1803921569, blue: 0.4078431373, alpha: 1)))
                        .font(Font.custom("cocon-bold",size: 20, relativeTo: .title3))
                    Text(board.description)
                        .font(.caption)
                        .foregroundColor(Color(#colorLiteral(red: 0.1921568627, green: 0.1803921569, blue: 0.4078431373, alpha: 1)))
                }
                .frame(height: reader.size.height * 0.3333)
                .padding(.init(top: 0, leading: 20, bottom: 3, trailing: 0))
            }
        }
    }
}

struct BoardCell_Previews: PreviewProvider {
    static var previews: some View {
        BoardCell(board: .init(uid: "", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""), reload: .constant(false))
    }
}
