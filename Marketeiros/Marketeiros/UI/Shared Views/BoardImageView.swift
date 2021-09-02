//
//  BoardImageView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 31/08/21.
//

import SwiftUI

struct BoardImageView: View {
    @Binding var board: Board
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
        VStack(spacing:0) {
            if !board.title.isEmpty {
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
            }
        }
        .onChange(of: board.uid, perform: { value in
            getImage()
        })
        .onAppear(perform: {
            getImage()
        })
     
    }
}

struct BoardImageView_Previews: PreviewProvider {
    static var previews: some View {
        BoardImageView(board: .constant(Board.init(
                        uid: "",
                        imagePath: "",
                        title: "Plani Board",
                        description: "",
                        instagramAccount: "",
                        ownerUid: "",
                        colaboratorsUids: [],
                        postsGridUid: "",
                        ideasGridUid: "",
                        moodGridUid: "")))
    }
}
