//
//  PastesDetailsView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 08/07/21.
//

import SwiftUI

struct PastesDetailsView: View {
    @ObservedObject var viewModel: PasteDetailsViewModel
    
    let layout = [
        GridItem(.fixed(170),spacing: 15),
        GridItem(.fixed(170),spacing: 15)
    ]
    
    init(paste: Paste, board: Board, ideas: [Idea]) {
        viewModel = PasteDetailsViewModel(paste: paste,board: board,ideas: ideas)
    }
    
    var body: some View {
        ScrollView() {
            LazyVGrid(columns: layout, spacing: 15) {
                ForEach(viewModel.ideas, id: \.uid) { idea in
                    NavigationLink(
                        destination: CreateIdeaSceneView(board: viewModel.board, pastes: [viewModel.paste]),
                        label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                                    .cornerRadius(22)
                                VStack(spacing: 5) {
                                    Text(idea.title)
                                        .foregroundColor(Color(#colorLiteral(red: 0.3098039216, green: 0.3058823529, blue: 0.3058823529, alpha: 1)))
                                        .font(.body)
                                        .fontWeight(.regular)
                                }
                                .frame(width: 170, height: 170, alignment: .center)
                                .background(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                                .cornerRadius(22)
                            }
                    })
                }
            }
        }
    }
}

struct PastesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PastesDetailsView(paste: .init(uid: "", title: "", icon: ""), board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""),ideas: [])
    }
}
