//
//  NewBoardSheet.swift
//  Marketeiros
//
//  Created by João Guilherme on 18/06/21.
//

import SwiftUI

struct NewBoardSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel : NewBoardViewModel
    
    init(callback: @escaping (Board) -> ()) {
        viewModel = NewBoardViewModel(callback: callback)
    }
    
    var body: some View {
        GeometryReader{ reader in
            VStack(alignment: .center ,spacing:25){
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.top)
                    .padding(.bottom,5)
                
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancelar")
                            .foregroundColor(Color(#colorLiteral(red: 0.8705882353, green: 0.3647058824, blue: 0.3647058824, alpha: 1)))
                            .font(.body)
                    })
                    Spacer()
                    Text("Novo quadro")
                        .foregroundColor(Color("SheetHeaderColor"))
                    Spacer()
                    Button(action: {
                        viewModel.createBoard()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Adicionar")
                            .foregroundColor(Color("SheetButton"))
                            .font(.body)
                    })
                }
                VStack(alignment:.leading, spacing: reader.size.height * 0.02){
                    HStack(spacing: 0){
                        Text("Nome do quadro").fontWeight(.regular)
                            .font(.title3)
                            .foregroundColor(Color("NavBarTitle"))
                            
                        Spacer()
                    }
                    TextField("Dê um nome ao seu quadro...", text: viewModel.bindings.title)
                        .frame(height:reader.size.height * 0.052)
                        .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                        .background(Color("TextField2"))
                        .cornerRadius(8)
                }
                
                VStack(alignment:.leading, spacing: reader.size.height * 0.02){
                    HStack(spacing: 0){
                        Text("Vincular à conta do Instagram").fontWeight(.regular)
                            .font(.title3)
                            .foregroundColor(Color("NavBarTitle"))
                        Spacer()
                    }
                    TextField("@usuário", text: viewModel.bindings.instragramAccount)
                        .frame(height:reader.size.height * 0.052)
                        .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                        .background(Color("TextField2"))
                        .cornerRadius(8)
                }
                
                VStack(alignment:.leading, spacing: reader.size.height * 0.02) {
                    Text("Bio do quadro").fontWeight(.regular)
                        .font(.title3)
                        .foregroundColor(Color("NavBarTitle"))
                    
                    TextField("Descreva em poucas palavras o seu quadro...",text: viewModel.bindings.description)
                        .frame(height: reader.size.height * 0.1317,alignment: .topLeading)
                        .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
                        .multilineTextAlignment(.leading)
                        .background(Color("TextField2"))
                        .foregroundColor(Color(#colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                        .cornerRadius(8)
                }
                
                VStack(alignment:.leading, spacing: reader.size.height * 0.02){
                    Text("Imagem do quadro").fontWeight(.regular)
                        .font(.title3)
                        .foregroundColor(Color("NavBarTitle"))
                    Button(action: {
                        viewModel.toggleImagePicker()
                    }, label: {
                        ZStack(alignment: .center){
                            Rectangle()
                                .foregroundColor(Color("TextField2"))
                            VStack {
                                if viewModel.states.inputImage != nil {
                                    Image(uiImage: viewModel.states.inputImage!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: reader.size.width * 0.90, height:reader.size.height * 0.2512)
                                        .clipped()
                                        
                                } else {
                                    Image(systemName: "camera")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: reader.size.width * 0.1413, height: reader.size.height * 0.0529)
                                    Text("Adicione uma capa")
                                }
                            }.foregroundColor(Color(#colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                        }
                    })
                    .frame(height:reader.size.height * 0.2512)
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal,20)
            .sheet(isPresented: viewModel.bindings.showingImagePicker) {
                ImagePicker(image: viewModel.bindings.inputImage, imagePath: viewModel.bindings.photoPath)
            }
        }
    }
}

struct NewBoardSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewBoardSheet(callback: {_ in})
    }
}
