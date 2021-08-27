//
//  ProfileSheet.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 23/08/21.
//

import SwiftUI

struct ProfileSheet: View {
    @Binding var boards: [Board]
    var okButtonCallback: () -> ()
    
    var body: some View {
        ScrollView {
            VStack {
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 50, height: 5)
                    .padding(.top)
                    .padding(.bottom,8)
                
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("Ok")
                    }).isHidden(true)
                    Spacer()
                    Text("Perfil")
                        .foregroundColor(Color("captionMessageColor"))
                    Spacer()
                    Button(action: {
                        okButtonCallback()
                    }, label: {
                        Text("Ok")
                    })
                }.padding()

                ForEach(boards, id: \.uid) { board in
                    VStack {
                        ProfileListCellView(board: board)
                            .padding()
                        Divider()
                    }
                }
                VStack(spacing: 25) {
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Image(systemName: "person.badge.plus")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Adicionar Perfil")
                                .font(Font.sfProDisplayRegular(sized: 18))
                            Spacer()
                        }
                        .foregroundColor(.white)
                    })
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color(UIColor.appLightBlue)))
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("Sair")
                        })
                        Spacer()
                    }
                    .foregroundColor(.red)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Text("Termos e Política")
                                .font(Font.sfProDisplayRegular(sized: 18))
                                .foregroundColor(.gray)
                        })
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("Ajuda")
                                .font(Font.sfProDisplayRegular(sized: 18))
                                .foregroundColor(.gray)
                        })
                    }
                    .padding(.horizontal)
                    
                }.padding()
            }
        }
        .background(CornerShapeView(corners: [.topLeft,.topRight], radius: 30).foregroundColor(Color(UIColor.systemBackground)))
    }
}

struct ProfileSheet_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Text("view atrás")
                Spacer()
            }
            ProfileSheet(boards: .constant(
                            [.init(uid: UUID().uuidString, imagePath: "", title: "Inspector", description: "", instagramAccount: "inspector", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: ""),
                            ]), okButtonCallback: {})
                .ignoresSafeArea()
                //.background(CornerShapeView(corners: [.topLeft,.topRight], radius: 30).accentColor(.red))
                .frame(height: 400)
                .padding(.horizontal,1)
        }.ignoresSafeArea()
    }
}
