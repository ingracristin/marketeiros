//
//  MoodBoardItemDetailsView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 05/07/21.
//

import SwiftUI

struct MoodBoardItemDetailsView: View {
    var body: some View {
        VStack{
            Text("Hello, World!")
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "trash").foregroundColor(.black)
                })
               
            }
        }
        
        
    }
    
}

struct MoodBoardItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MoodBoardItemDetailsView()
        }
    }
}
