//
//  AcountListCellSwiftUIView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 17/06/21.
//

import SwiftUI

struct ListTeamsUIView: View {
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.yellow)
                .frame(width: 390, height: 61)
            
            HStack(){
                Image("bolinha2")
                VStack(spacing: 2){
                    HStack(){
                        Text("Ingra Top")
                        Spacer()
                            Menu(content: {
                                Button(action: {}) {
                                    Text("Tornar adm")
                                }
                                Button(action: {}) {
                                    Text("Deletar do time")
                                }
                            }, label: {
                                Text("Administrador")
                                    .padding(.horizontal,40)
                                    .foregroundColor(.gray)
                            })
                        Text("...")

                    }
                    
                    HStack(){
                        Text("@ingrata")
                       
                        Spacer()
                    }
                    
                }
                
                
                Spacer()
            }.padding(.horizontal,25)

           

        }
    }
}

struct ListTeamsUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListTeamsUIView()
    }
}
