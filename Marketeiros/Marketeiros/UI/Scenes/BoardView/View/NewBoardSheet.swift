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
                    Button(action: {}, label: {
                        Text("Cancelar")
                            .foregroundColor(.red)
                            .font(.body)
                    })
                    Spacer()
                    Text("Novo quadro")
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        viewModel.createBoard()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Adicionar")
                            .foregroundColor(.gray)
                            .font(.body)
                    })
                }
                VStack(alignment:.leading, spacing: reader.size.height * 0.02){
                    HStack(spacing: 0){
                        Text("Nome do quadro").fontWeight(.semibold)
                            .font(.callout)
                        
                        Spacer()
                    }
                    TextField("", text: viewModel.bindings.title)
                        .frame(height:reader.size.height * 0.052)
                        .background(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                        .cornerRadius(8)
                }
                VStack(alignment:.leading, spacing: reader.size.height * 0.02){
                    
                    Text("Bio do quadro").fontWeight(.semibold)
                        .font(.callout)
                    
                    TextEditor(text: viewModel.bindings.description)
                        .colorMultiply(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                        .cornerRadius(8)
                        .frame(height: reader.size.height * 0.1317)
                }
                
                VStack(alignment:.leading, spacing: reader.size.height * 0.02){
                    Text("Imagem do quadro").fontWeight(.semibold)
                        .font(.callout)
                    Button(action: {}, label: {
                        ZStack(alignment: .center){
                            Rectangle()
                                .foregroundColor(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                            VStack{
                                Image(systemName: "camera")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: reader.size.width * 0.1413, height: reader.size.height * 0.0529)
                                Text("Adicione uma capa")
                            }.foregroundColor(Color(#colorLiteral(red: 0.3106196523, green: 0.3057384491, blue: 0.3057644367, alpha: 1)))
                        }
                    })
                    .frame(height:reader.size.height * 0.2512)
                    .cornerRadius(8)
                }
            }.background(BlurView(style: .systemMaterial))
            .padding(.horizontal,20)
        }
    }
}

struct NewBoardSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewBoardSheet(callback: {_ in})
    }
}
