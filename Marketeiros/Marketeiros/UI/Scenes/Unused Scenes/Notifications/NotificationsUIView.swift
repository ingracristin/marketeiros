//
//  NotificationsUIView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 24/06/21.
//

import SwiftUI

struct NotificationsUIView: View {
    var body: some View {
        VStack(){
            HStack(){
                Text("Dia")
                    .font(.system(size: 20))
                    .padding(.horizontal)
                Spacer()
            }

            ForEach(0..<5, id:\.self){ index in
                ZStack(){
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.yellow)
                        .frame(width: 390, height: 62)
                    
                    HStack(){
                        Image("bolinha")
                            .resizable()
                            .frame(width: 39, height: 39)
                        Text("Fulano de Tal adicionou um comentário no seu rascunho: ”EU AMEI A IDEIA!!!!!")
                            .font(.system(size: 12))
                        Spacer()
                        Image("retangulinho")
                            .resizable()
                            .frame(width: 39, height: 39)
                        
                        
                        
                    }.padding(.horizontal,25)

                   

                }
            }
           
            Spacer()
        }.navigationTitle("Notificações")
    }
}

struct NotificationsUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NotificationsUIView()
        }
    }
}
