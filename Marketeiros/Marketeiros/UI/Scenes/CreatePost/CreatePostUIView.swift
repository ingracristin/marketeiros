//
//  CreatePostUIView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 25/06/21.
//

import SwiftUI

struct CreatePostUIView: View {
    @State var titlePost: String = ""
    @State var legendPost: String = ""
    @State var hastagPost: String = ""
    @State var markPost: String = ""
    @State private var showGreeting = true
    
    @State private var image: Image?
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }

    
    var body: some View {
        ScrollView(){
            HStack{
                Button(action: {}, label: {
                    Text("setinha")
                        .foregroundColor(.blue)
                        .font(.body)
                    
                })
                Spacer()
                Text("Criar post")
                    .foregroundColor(.black)
                Spacer()
                Button(action: {}, label: {
                    Text("Salvar")
                        .foregroundColor(.blue)
                        .font(.body)
                    
                })
            }.padding(.horizontal)
            Spacer()
        
            VStack(spacing: 10){
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    

                    if image != nil {
                        image?
                            .resizable()
                            .frame(width: 390, height: 300)
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                Spacer()
                HStack{
                    Text("Título")
                    Spacer()
                    
                    ZStack(alignment:.trailing){
                        TextField("E-mail do convidado", text: $titlePost)
                            .padding()
                            .frame(width: 253, height: 50)
                            .background(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                            .cornerRadius(8)
                    }
                }.padding(.horizontal,20)
                
                HStack{
                    Text("Legenda")
                    Spacer()
                    ZStack(alignment:.trailing){
                        TextField("Legswddwendas", text: $legendPost)
                            .padding()
                            //.frame(height:reader.size.height * 0.052)
                            .frame(width: 253, height: 100)
                            .background(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                            .cornerRadius(8)
                    }
                }.padding(.horizontal,20)
                
                HStack{
                    Text("Hastags")
                    Spacer()
                    ZStack(alignment:.trailing){
                        TextField("#", text: $hastagPost)
                            .padding()
                            .frame(width: 253, height: 50)
                            .background(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                            .cornerRadius(8)
                    }
                }.padding(.horizontal,20)
                
                HStack{
                    Text("Marcados")
                    Spacer()
                    ZStack(alignment:.trailing){
                        TextField("E-mail do convidado", text: $markPost)
                            .padding()
                            .frame(width: 253, height: 50)
                            .background(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                            .cornerRadius(8)
                    }
                }.padding(.horizontal,20)
                Spacer()
                HStack(){
                    Toggle("Agendar", isOn: $showGreeting)
                    
                }.padding(.horizontal,31)
                HStack(){
                    Toggle("Instagram", isOn: $showGreeting)
                }.padding(.horizontal,31)
            
            }
        }.padding(.vertical,20)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        
        
    }
}

struct CreatePostUIView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostUIView()
    }
}
