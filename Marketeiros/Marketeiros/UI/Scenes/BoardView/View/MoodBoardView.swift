//
//  MoodBoardView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 05/07/21.
//

import SwiftUI

struct MoodBoardView: View {
    var body: some View {
        VStack{
            Text("Voce ainda nao tem nada aqui mano")
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button(action: {
                    MoodHalfModalView(offset: .constant(10))
                }, label: {
                    Image(systemName: "plus").foregroundColor(.black)
                })
               
            }
        }
        
        
        
    }
}

struct MoodBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MoodBoardView()
        }
        
    }
}
