//
//  MoodBoardView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 02/07/21.
//

import SwiftUI

struct MoodBoardGridView: View {
    @Binding var imagesList: [UIImage]
    
    var body: some View {
        var gridItems: [GridCell] = []
        for image in imagesList {
            let randomH = CGFloat.random(in: 180 ... 300)
            gridItems.append(GridCell(height: randomH, image: image))
        }
        
        return ScrollView{
            PinterestGrid(gridItems: gridItems, numOfColumns: 2, spacing: 20, horizontalPadding: 20)
        }
    }
}

struct MoodBoardGridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoodBoardGridView(imagesList: .constant([]))
        }
    }
}
