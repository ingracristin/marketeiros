//
//  ProfileListCellView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 23/08/21.
//

import SwiftUI

struct ProfileListCellView: View {
    let board: Board
    @State var image: UIImage!
    
    func getImage() {
        ImagesRepository.current.getImage(of: board) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let image):
                self.image = image
            }
        }
    }
    
    var body: some View {
        HStack {
            if image == nil {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 48, height:48)
            } else {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 48, height:48)
            }
            
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
