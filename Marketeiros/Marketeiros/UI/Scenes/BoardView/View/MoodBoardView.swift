//
//  MoodBoardView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 02/07/21.
//

import SwiftUI

struct MoodBoardView: View {
    var body: some View {
        var gridItems = [GridCell]()
        for i in 0 ..< 30 {
            let randomH = CGFloat.random(in: 180 ... 300)
            gridItems.append(GridCell(height: randomH))
        }
        
        return ScrollView{
            PinterestGrid(gridItems: gridItems, numOfColumns: 2, spacing: 20, horizontalPadding: 20)
        }
        
    }
}

struct MoodBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoodBoardView()
        }
        
    }
}
