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
    @State var lastImage: UIImage? = UIImage(named: "bolinha")!
    @State var localeImage: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                if imagesList.isEmpty {
//                    Image("moodBooardBg")
//                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7155, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .scaledToFill()
//                        .ignoresSafeArea()
                }
                MoodBoardGridView(imagesList: $imagesList)
            }
            .actionSheet(isPresented: $showingActionSheet, content: {
                .init(title: Text("New Media"), buttons: [
                    .default(Text("Photos and Videos"), action: {
                        imageGalery.toggle()
                    }),
                    .cancel()
                ])
            })
            .sheet(isPresented: $imageGalery, onDismiss: {
                if(uiImage != nil && uiImage != lastImage){
                    imagesList.append(uiImage!)
                    lastImage = uiImage
                }
                    }, content: {
                ImagePicker(image: $uiImage, imagePath: $localeImage)
            })
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
