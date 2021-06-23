//
//  UserProfileGridView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 23/06/21.
//

import SwiftUI

struct UserProfileGridView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            if viewModel.imagesUrls.isEmpty {
                Text("Loading...")
            } else {
                LazyVGrid(columns: [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))], content: {
                    ForEach(viewModel.imagesUrls, id: \.self) { url in
                        AsyncImage(url: URL(string: url)!) {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.gray)
                        } image: {
                            Image(uiImage: $0)
                                .resizable()
                        }
                        .frame(width: 100, height: 100, alignment: .center)
                    }
                })
            }
            
            TestWebView(vm: viewModel)
                //.isHidden(true)
                .frame(width: 0, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .onAppear(perform: {
                    print("rebuildo essa porra")
                })
        }
    }
}

struct UserProfileGridView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileGridView()
    }
}

