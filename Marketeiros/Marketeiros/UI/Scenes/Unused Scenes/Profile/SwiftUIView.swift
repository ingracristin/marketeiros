//
//  ProfileView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 15/06/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(){
            HStack(){
                Text("Perfil").font(.system(size: 24, weight: Font.Weight.bold, design: Font.Design.rounded))
                    .padding()
                Spacer()
            }
            HStack(){
                Image("bolinha")
                VStack(){
                    Text("Ingra Cristina")
                    Text("@ingracristin")
                }
                Spacer()
            }.padding()
            Spacer()
            VStack(){
                HStack(){
                    Text("Contas").font(.system(size: 24, weight: Font.Weight.bold, design: Font.Design.rounded))
                        .padding()
                    Spacer()
                }
                

                Text("Contas")
                Text("Contas")
                Text("Contas")
                
            }
            Spacer()
            
            VStack(){
                HStack(){
                    Text("Time").font(.system(size: 24, weight: Font.Weight.bold, design: Font.Design.rounded))
                        .padding()
                    Spacer()
                }
                HStack(){
                    Text("Contas")
                }.background(RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.init(.green)))

                
               
                
            }
            Spacer()
            
        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
