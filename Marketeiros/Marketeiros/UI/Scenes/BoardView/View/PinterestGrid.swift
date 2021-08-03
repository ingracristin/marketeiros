//
//  PinterestGrid.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 02/07/21.
//

import SwiftUI

struct GridCell: Identifiable {
    let id = UUID()
    let height: CGFloat
    let image: UIImage
}

struct PinterestGrid: View {
    struct  Column: Identifiable {
        let id = UUID()
        var gridItems = [GridCell]()
    }
    let columns: [Column]
    
    var spacing: CGFloat = 10
    var horizontalPadding: CGFloat = 10
    
    init(gridItems: [GridCell], numOfColumns: Int, spacing: CGFloat = 20, horizontalPadding: CGFloat = 20) {
        self.spacing = spacing
        self.horizontalPadding = horizontalPadding
        
        var columns = [Column]()
        for _ in 0 ..< numOfColumns {
            columns.append(Column())
        }
        
        var columnsHeight = Array<CGFloat>(repeating: 0, count: numOfColumns)
        
        for gridItem in gridItems {
            var smallesColumnIndex = 0
            var smallesHeight = columnsHeight.first!
            
            for i in 1 ..< columnsHeight.count {
                let curHeight = columnsHeight[i]
                if curHeight < smallesHeight {
                    smallesHeight = curHeight
                    smallesColumnIndex = i
                }
            }
            columns[smallesColumnIndex].gridItems.append(gridItem)
            columnsHeight[smallesColumnIndex] += gridItem.height
        }
        self.columns = columns
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing){
            ForEach(columns) { column in
                LazyVStack(spacing: spacing){
                    ForEach(column.gridItems) { gridItem in
                        NavigationLink(destination: MoodBoardItemDetailsView()) {
                            Image(uiImage: gridItem.image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: gridItem.height)
                                .clipped()
                                .cornerRadius(10)
                                
                        }
                        }
                    }
                }
            }
            .padding(.horizontal, horizontalPadding)
        }
    }
    
    struct PinterestGrid_Previews: PreviewProvider {
        static var previews: some View {
            PinterestGrid(gridItems: [GridCell(height: 200, image: UIImage(named: "bolinha")!)], numOfColumns: 4)
        }
    }
