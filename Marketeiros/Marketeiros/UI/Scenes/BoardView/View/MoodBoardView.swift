//
//  MoodBoardView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 05/07/21.
//

import SwiftUI

struct MoodBoardView: View {
    var flag: Bool = false
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                MoodHalfModalView(offset: .constant(10))
                    .frame(height: 120)
            }
            
            VStack{
                Text("Voce ainda nao tem nada aqui mano")
            }
            
        }.toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Button(action: {
                    
                    
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
