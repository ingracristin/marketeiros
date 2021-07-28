//
//  PostsGridCellView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 20/07/21.
//

import SwiftUI

struct PostsGridCellView: View {
    var post: Post
    var board: Board
    var height: CGFloat
    var width: CGFloat
    @Binding var averageColorOn: Bool
    
    var body: some View {
        ZStack(alignment:.topTrailing){
            FirebaseImage(post: post, board: board, widthImg: width, heightImg: height, averageColorOn: $averageColorOn) {
                Rectangle()
                    .foregroundColor(Color(UIColor.emptyCellGridColor))
                
            } image: {
                Image(uiImage: $0)
            }
            .frame(width: width,height: height, alignment: .center)
            .contextMenu {
                Button(action:{}){
                    HStack{
                        Text(NSLocalizedString("share", comment: ""))
                        Image(systemName: "square.and.arrow.up")
                    }
                }

                Button(action:{}){
                    HStack{
                        Text(NSLocalizedString("delete", comment: ""))
                        Image(systemName: "trash")
                    }.foregroundColor(.red)
                }
            }
        }
    }
}

struct PostsGridCellView_Previews: PreviewProvider {
    static var previews: some View {
        PostsGridCellView(
            post: .T(uid: "fsdfsdf", photoPath: "", title: "", description: "", hashtags: [], markedAccountsOnPost: [], dateOfPublishing: .init()),
            board:  .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""),
            height: 100,
            width: 70,
            averageColorOn: .constant(false))
    }
}
