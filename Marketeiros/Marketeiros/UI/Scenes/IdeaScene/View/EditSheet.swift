//
//  EditSheet.swift
//  Marketeiros
//
//  Created by João Guilherme on 01/07/21.
//

import SwiftUI

struct EditSheet: View {
    var body: some View {
        GeometryReader{ reader in
            VStack(alignment: .leading,spacing:15){
                HStack{
                    Spacer()
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 50, height: 5)
                        .padding(.top)
                        .padding(.bottom,5)
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Text("Editar")
                        .font(.title3)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    Spacer()
                }
                                
                Spacer().frame(height: reader.size.height * 0.0246)
                VStack(alignment:.leading, spacing: 35){
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "pencil")
                                .foregroundColor(Color(#colorLiteral(red: 0.3106196523, green: 0.3057384491, blue: 0.3057644367, alpha: 1)))
                            Text("Alterar nome da pasta")
                                .foregroundColor(Color(#colorLiteral(red: 0.3960410953, green: 0.3961022794, blue: 0.3960276842, alpha: 1)))
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        
                        
                    })
                    
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "sparkles")
                                .foregroundColor(Color(#colorLiteral(red: 0.3106196523, green: 0.3057384491, blue: 0.3057644367, alpha: 1)))
                            Text("Alterar ícone")
                                .foregroundColor(Color(#colorLiteral(red: 0.3960410953, green: 0.3961022794, blue: 0.3960276842, alpha: 1)))
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        
                        
                    })
                    
                    Button(action: {}, label: {
                        HStack{
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                            Text("Apagar pasta")
                                .foregroundColor(.red)
                                .font(.body)
                                .fontWeight(.regular)
                        }
                        
                        
                    })
                }.padding(.horizontal,35)
                
                
                
            }
        }
    }
}

struct EditSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditSheet()
    }
}
