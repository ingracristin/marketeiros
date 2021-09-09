//
//  ProfileSheet.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 23/08/21.
//

import SwiftUI

struct ProfileSheet: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var insideViewModel: InsideBoardViewModel
    @Binding var boards: [Board]
    @Binding var board: Board
    var okButtonCallback: () -> ()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
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
                            .foregroundColor(Color(UIColor.appLightBlue))
                    }).isHidden(true)
                    Spacer()
                    Text(NSLocalizedString("profile", comment: ""))
                        .font(Font.sfProDisplaySemiBold(sized: 15))
                        .foregroundColor(Color("SheetHeaderColor"))
                    Spacer()
                    Button(action: {
                        okButtonCallback()
                    }, label: {
                        Text("Ok")
                            .font(Font.sfProDisplaySemiBold(sized: 15))
                            .foregroundColor(Color(UIColor.appLightBlue))
                    })
                }.padding(.horizontal,20)

                ForEach(boards, id: \.uid) { board in
                    VStack {
                        ProfileListCellView(board: board)
                            .padding(.vertical)
                            .onTapGesture {
                                //LocalRepository.shared.saveCurrent(board: board)
                                self.board = board
                            }.environmentObject(insideViewModel)
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(Color("DividerColor"))
                            
                    }.padding(.horizontal)
                }
                Spacer()
                VStack(spacing: 25) {
                    NavigationLink(
                        destination: AddProfileView(),
                        label: {
                            HStack {
                                Spacer()
                                Image(systemName: "person.badge.plus")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text(NSLocalizedString("addProfile", comment: ""))
                                    .font(Font.sfProDisplayRegular(sized: 18))
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 25).foregroundColor(Color(UIColor.appLightBlue)))
                        })
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            authenticationViewModel.signOut()
                        }, label: {
                            Text(NSLocalizedString("logOut", comment: ""))
                        })
                        Spacer()
                    }
                    .foregroundColor(.red)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Text(NSLocalizedString("terms", comment: ""))
                                .font(Font.sfProDisplayRegular(sized: 18))
                                .foregroundColor(.gray)
                        })
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text(NSLocalizedString("help", comment: ""))
                                .font(Font.sfProDisplayRegular(sized: 18))
                                .foregroundColor(.gray)
                        })
                    }
                    //.padding(.horizontal)
                    .padding(.bottom)
                }.padding()
            }
        }
        .padding(.horizontal)
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
                            ]), board: .constant(.init(uid: UUID().uuidString, imagePath: "", title: "Inspector", description: "", instagramAccount: "inspector", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: "")), okButtonCallback: {})
                .ignoresSafeArea()
                //.background(CornerShapeView(corners: [.topLeft,.topRight], radius: 30).accentColor(.red))
                .frame(height: 400)
                .padding(.horizontal,1)
        }.ignoresSafeArea()
    }
}
