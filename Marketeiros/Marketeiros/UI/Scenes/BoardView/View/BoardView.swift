//
//  BoardView.swift
//  Marketeiros
//
//  Created by João Guilherme on 16/06/21.
//

import SwiftUI

struct BoardView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Boards")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                Spacer()
                Button(action: {}, label: {
                    Text("Add Board")
                        .foregroundColor(.white)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.init(top: 5, leading: 12, bottom: 5, trailing: 12))
                        .background(RoundedRectangle(cornerRadius: 10))
                })
            }
            
            ScrollView(.horizontal){
                LazyHStack(alignment: .top, spacing: 10, content: {
                    ForEach(1...10, id: \.self) { count in
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                        })
                    }
                })
            }
        }.padding(.horizontal,20)
    }

}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
