//
//  MoodBoardView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 05/07/21.
//

import SwiftUI

struct MoodBoardView: View {
    var flag: Bool = false
    @State var imagesList = [UIImage]()
    @State var showingActionSheet = false
    @State var imageGalery = false
    @State var uiImage: UIImage? = UIImage(named: "bolinha")!
    @State var localeImage: String = ""
    var body: some View {
            
        ScrollView {
            VStack{
                MoodBoardGridView(imagesList: $imagesList)
                Text("Voce ainda nao tem nada aqui mano")
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Spacer()
                            Button(action: {
                                showingActionSheet = true
                                    
                                
                            }, label: {
                                Image(systemName: "plus").foregroundColor(.black)
                            })
                           
                        }
                    }
            }.actionSheet(isPresented: $showingActionSheet, content: {
                .init(title: Text("das"), message: Text("dasdas"), buttons: [
                    .default(Text("Fotos ou Videos"), action: {
                        imageGalery.toggle()
                    }),
                    .cancel()
                ])
            }).sheet(isPresented: $imageGalery, onDismiss: { imagesList.append(uiImage!)}, content: {
                ImagePicker(image: $uiImage, imagePath: $localeImage)
            })
            

       
        
        
        
    }
        }
}

struct MoodBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MoodBoardView()
        }
        
    }
}
