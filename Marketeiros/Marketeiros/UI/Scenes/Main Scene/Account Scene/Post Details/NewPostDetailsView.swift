//
//  NewPostDetailsView.swift
//  Marketeiros
//
//  Created by João Guilherme on 21/07/21.
//

import SwiftUI

struct NewPostDetailsView: View {
    @ObservedObject var viewModel: PostDetailsViewModel
    
    init(post: Post, board: Board) {
        viewModel = .init(post: post, board: board)
    }
    
    var body: some View {
        VStack(alignment:.leading){
            Image("ImageTest")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width * 0.9066, height: UIScreen.main.bounds.size.height * 0.3756)
                .clipped()
                .cornerRadius(24)
            
            Spacer().frame(height: UIScreen.main.bounds.size.height * 0.0320)
            
            VStack(alignment:.leading,spacing: 15){
                HStack{
                    ZStack(alignment:.center){
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.size.width * 0.2346, height: UIScreen.main.bounds.size.height * 0.0258)
                            .foregroundColor(Color("postInstaTag"))
                            .cornerRadius(6)
                        Text("@dance4art")
                            .font(.custom("SF Pro Display", size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
                
                Text("Lorem ipsum dolor sit amet")
                    .font(.custom("SF Pro Display", size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("postTitle"))
                
                
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra tellus ut quis volutpat, cras risus nibh varius venenatis. Volutpat at posuere dolor ac nunc. Consequat, maecenas elementum et malesuada varius. Ac, ultrices nunc bibendum non. Non metus nisl interdum nunc vitae, ultricies semper suscipit commodo. Et amet magnis duis.").multilineTextAlignment(.leading)
                    .font(.custom("SF Pro Display", size: 14))
                    .foregroundColor(Color("postText"))
            }
            
            
            Spacer().frame(height: UIScreen.main.bounds.size.height * 0.0307)
            
            Text("#danca #conceito #verde")
                .font(.custom("SF Pro Display", size: 14))
                .fontWeight(.regular)
                .foregroundColor(Color("postText"))
            
            Spacer().frame(height: UIScreen.main.bounds.size.height * 0.0492)
            
            HStack{
                Text("Agendado")
                Spacer()
                Text("4 de Nov. de 2021")
                Spacer()
                Text("11:00 PM")
            }
            .padding(15)
            .foregroundColor(Color("postScheduleText"))
            .background(Color("postBackgroundSchedule"))
            .cornerRadius(8)
            
            Spacer()
            
        }.padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20))
        .navigationBarTitle("Post", displayMode: .inline)
        .navigationBarItems(trailing:
                                Menu(content: {
                                    Button(action:{}){
                                        HStack{
                                            Text(NSLocalizedString("edit", comment: ""))
                                            Image(systemName: "square.and.pencil")
                                        }
                                    }
                                    Button(action:{}){
                                        HStack{
                                            Text(NSLocalizedString("deletePost", comment: ""))
                                            Image(systemName: "trash")
                                        }.foregroundColor(.red)
                                    }
                                },label: {
                                    Text("...")
                                        .font(Font.sfProDisplaySemiBold(sized: 17))
                                        .foregroundColor(Color(UIColor.navBarItemsColor))
                                        
                                }))
    }
}

struct NewPostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NewPostDetailsView(post: .T(uid: "", photoPath: "", title: "", description: "", hashtags: [""], markedAccountsOnPost: [""], dateOfPublishing: Date()), board: Board(uid: "", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
        }
        
    }
}
