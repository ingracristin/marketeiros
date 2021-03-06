//
//  ProfileListCellView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 23/08/21.
//

import SwiftUI

struct ProfileListCellView: View {
    @EnvironmentObject var insideViewModel: InsideBoardViewModel
    @State var board: Board
    @State var image: UIImage!
    
    init(board: Board) {
        self.board = board
    }
    
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
    
    var instagramAccount: String {
        let title = board.instagramAccount.removeCharactersContained(in: "@")
        return (title.isEmpty) ? "@username" : "@\(title)"
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
                    .foregroundColor(Color("cameraColor"))
                Text(instagramAccount)
                    .font(Font.sfProDisplayMedium(sized: 12))
                    .fontWeight(.light)
                    .foregroundColor(Color("captionMessageColor"))
            }
            Spacer()
            NavigationLink(destination: EditProfileView(board: board, callback: { newBoard in
                //insideViewModel.change(board: newBoard)
                if insideViewModel.states.board.uid == newBoard.uid {
                    insideViewModel.states.board = newBoard
                    LocalRepository.shared.saveCurrent(board: newBoard)
                }
                self.board = newBoard
            }).environmentObject(insideViewModel)) {
                Image(systemName: "pencil.circle")
                    .foregroundColor(Color(UIColor.appLightBlue))
            }
            .padding(.trailing)
            
        }.onAppear(perform: {
            getImage()
        })
    }
}

struct ProfileListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListCellView(board: .T(uid: "", imagePath: "", title: "Inspector", description: "", instagramAccount: "inspector", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
    }
}
