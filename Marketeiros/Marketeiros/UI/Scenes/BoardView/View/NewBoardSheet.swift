//
//  NewBoardSheet.swift
//  Marketeiros
//
//  Created by João Guilherme on 18/06/21.
//

import SwiftUI

struct NewBoardSheet: View {
    @State var boardName: String = ""
    @State var selectdRole: String = "Editor"
    var body: some View {
        GeometryReader{ reader in
            VStack(spacing:25){
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.top)
                    .padding(.bottom,5)
                HStack{
                    Button(action: {}, label: {
                        Text("Cancelar")
                            .foregroundColor(.red)
                            .font(.body)
                        
                    })
                    Spacer()
                    Text("Novo quadro")
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {}, label: {
                        Text("Adicionar")
                            .foregroundColor(.gray)
                            .font(.body)
                        
                    })
                }
                VStack(alignment:.leading, spacing: reader.size.height * 0.02){
                    HStack(spacing: 0){
                        Text("Nome do quadro").fontWeight(.semibold)
                            .font(.callout)
                        Text("*").foregroundColor(.red)
                        Spacer()
                    }
                    TextField("", text: $boardName)
                        .frame(height:reader.size.height * 0.052)
                        .background(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                        .cornerRadius(8)
                }
                VStack(alignment:.leading, spacing: reader.size.height * 0.02){
                    
                    Text("Adicione colaboradores").fontWeight(.semibold)
                        .font(.callout)
                    
                    
                    HStack{
                        ZStack(alignment:.trailing){
                            TextField("E-mail do convidado", text: $boardName)
                                .padding()
                                .frame(height:reader.size.height * 0.052)
                                .background(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                                .cornerRadius(8)
                            
                            Menu(content: {
                                Button("Editor", action: editorSelect)
                                Button("Leitor", action: readerSelect)
                            }, label: {HStack(spacing: 5){
                                Text(selectdRole)
                                    .foregroundColor(Color(#colorLiteral(red: 0.3106196523, green: 0.3057384491, blue: 0.3057644367, alpha: 1)))
                                    .font(.body)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color(#colorLiteral(red: 0.3106196523, green: 0.3057384491, blue: 0.3057644367, alpha: 1)))
                                
                            }
                            }).frame(height: reader.size.height * 0.052)
                            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                            
                            
                            
                            
                        }
                        Button(action: {}, label: {
                            Image(systemName: "paperplane").foregroundColor(.black)
                            
                        })
                        .frame(width:reader.size.height * 0.052, height: reader.size.height * 0.052)
                        .background(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                        .cornerRadius(reader.size.height * 0.052)
                        
                        
                    }
                    
                    
                }
                
                VStack(alignment:.leading, spacing: reader.size.height * 0.02){
                    
                    Text("Convidar por link").fontWeight(.semibold)
                        .font(.callout)
                    
                    
                    HStack{
                        ZStack(alignment:.trailing){
                            TextField("https://da-br.zoom.us/859...", text: $boardName)
                                .padding()
                                .frame(height:reader.size.height * 0.052)
                                .background(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                                .cornerRadius(8)
                            
                            Menu(content: {
                                Button("Editor", action: editorSelect)
                                Button("Leitor", action: readerSelect)
                            }, label: {HStack(spacing: 5){
                                Text(selectdRole)
                                    .foregroundColor(Color(#colorLiteral(red: 0.3106196523, green: 0.3057384491, blue: 0.3057644367, alpha: 1)))
                                    .font(.body)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color(#colorLiteral(red: 0.3106196523, green: 0.3057384491, blue: 0.3057644367, alpha: 1)))
                                
                            }
                            }).frame(height: reader.size.height * 0.052)
                            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                            
                            
                            
                            
                        }
                        Button(action: {}, label: {
                            Image(systemName: "doc.on.doc").foregroundColor(.black)
                            
                        })
                        .frame(width:reader.size.height * 0.052, height: reader.size.height * 0.052)
                        .background(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                        .cornerRadius(reader.size.height * 0.052)
                        
                        
                    }
                    
                    
                }
                Spacer()
                
            }.background(BlurView(style: .systemMaterial))
            .padding(.horizontal,20)
        }
        
    }
    func editorSelect(){
        selectdRole = "Editor"
    }
    func readerSelect(){
        selectdRole = "Leitor"
    }
}

struct NewBoardSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewBoardSheet()
    }
}
