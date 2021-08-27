//
//  ProfileListCellView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 23/08/21.
//

import SwiftUI

struct ProfileListCellView: View {
    let board: Board
    var body: some View {
        HStack {
            Image("ImageTest")
                .resizable()
                .frame(width: 48, height:48)
            VStack(alignment: .leading) {
                Text(board.title)
                    .font(Font.sfProDisplayMedium(sized: 18))
                    .foregroundColor(Color(UIColor.appDarkBlue))
                Text(board.instagramAccount)
                    .font(Font.sfProDisplayMedium(sized: 12))
                    .fontWeight(.light)
                    .foregroundColor(Color(UIColor.appLightGrey))
            }
            Spacer()
            Button(action: {
                
            }, label: {
                Image(systemName: "pencil.circle")
            })
        }
    }
}

struct ProfileListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListCellView(board: .T(uid: "", imagePath: "", title: "Inspector", description: "", instagramAccount: "inspector", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
    }
}
