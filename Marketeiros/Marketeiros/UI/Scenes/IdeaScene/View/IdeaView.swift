//
//  SceneView.swift
//  Marketeiros
//
//  Created by João Guilherme on 29/06/21.
//

import SwiftUI

struct IdeaView: View {
    let layout = [
        GridItem(.fixed(170),spacing: 15),
        GridItem(.fixed(170),spacing: 15)
    ]
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                Text("Pastas")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                ScrollView(.horizontal){
                    LazyHStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                        Button(action: {}, label: {
                            HStack{
                                Image(systemName: "folder")
                                    .foregroundColor(Color(#colorLiteral(red: 0.3960410953, green: 0.3961022794, blue: 0.3960276842, alpha: 1)))
                                Text("Nova pasta")
                                    .foregroundColor(Color(#colorLiteral(red: 0.3960410953, green: 0.3961022794, blue: 0.3960276842, alpha: 1)))
                                    .font(.caption)
                                    .fontWeight(.regular)
                            }
                        }).frame(width:150, height:50)
//                        .frame(width: reader.size.width * 0.2933, height: reader.size.height * 0.0566, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                        .cornerRadius(12)
                        ForEach(1...10, id: \.self) { count in
                            Button(action: {}, label: {
                                ZStack(alignment: .center) {
                                    Rectangle()
//                                        .frame(width: reader.size.width * 0.2933, height: reader.size.height * 0.0566, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width:150, height:50)
                                        .foregroundColor(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                                        .cornerRadius(12)
                                    HStack {
                                        Text("⭐️")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        Text("Produtos")
                                            .foregroundColor(Color(#colorLiteral(red: 0.3960410953, green: 0.3961022794, blue: 0.3960276842, alpha: 1)))
                                            .font(.caption)
                                            .fontWeight(.regular)
                                    }
                                }
                            })
                        }
                    }).frame(height: 70)
                }
                //.fixedSize()
                Text("Cartões de ideias")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                ScrollView() {
                    LazyVGrid(columns: layout, spacing: 15) {
                        ForEach(1...18, id: \.self) { cell in
                            if(cell == 1) {
                                Button(action: {}, label: {
                                    VStack(spacing: 5) {
                                            Image(systemName: "sparkles.rectangle.stack.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundColor(.black)
//                                                .frame(width: reader.size.width * 0.0826, height: reader.size.height * 0.0357, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            Text("Adicionar ideia")
                                                .foregroundColor(Color(#colorLiteral(red: 0.3098039216, green: 0.3058823529, blue: 0.3058823529, alpha: 1)))
                                                .font(.body)
                                                .fontWeight(.regular)
                                        }
                                })
//                                .frame(width: reader.size.width * 0.4293, height: reader.size.height * 0.1908)
                                .background(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                                .cornerRadius(22)
                            } else {
                                ZStack {
                                    Rectangle()
//                                        .frame(width: reader.size.width * 0.4293, height: reader.size.height * 0.1908)
                                        .foregroundColor(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                                        .cornerRadius(22)
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("📒 🙂")
                                        Text("loren ipsun hsjd ksdk jsdk sjd hsj hsnks jsnd hshdk shdnks hsdk shdks dhks")
                                    }.padding(.horizontal,20)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SceneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TabView {
                IdeaView()
                    .padding()
            }
        }
    }
}
