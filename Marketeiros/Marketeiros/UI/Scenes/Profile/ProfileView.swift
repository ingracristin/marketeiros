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
                Image("bolinha")
                VStack(){
                    Text("Ingra Cristina")
                    Text("@ingracristicvn")
                }
                Spacer()
            }.padding()
            
            VStack(){
                
                HStack(){
                    Text("Contas").font(.system(size: 24, weight: Font.Weight.bold, design: Font.Design.rounded))
                        
                    Spacer()
                    
                    Button("r") {
                    }
                    .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                    
                        
                }.padding(.horizontal)
                VStack(){
                    ForEach(0..<2, id:\.self){ index in 
                        AcountListCellSwiftUIView()
                    }
                }
               
                
                
            }
            Spacer()
            
          
            Spacer()
            
        }.navigationBarItems(trailing: Button(action: {}, label: {
            Image(systemName: "gearshape").foregroundColor(.black)
        })).navigationTitle("Perfil")
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView()
        }
        
    }
}
