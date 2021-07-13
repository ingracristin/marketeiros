//
//  SearchView.swift
//  Marketeiros
//
//  Created by João Guilherme on 01/07/21.
//

import SwiftUI

struct SearchView: View {
    let layout = [
        GridItem(.flexible(),spacing: 15),
        GridItem(.flexible(),spacing: 15)
    ]
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        GeometryReader{ reader in
            VStack{
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Busque ideias...", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .navigationBarHidden(showCancelButton)
                ScrollView(){
                    LazyVGrid(columns: layout, spacing: 15){
                        ForEach(1...18, id: \.self){ cell in
                            
                            ZStack{
                                Rectangle()
                                    .frame(width: reader.size.width * 0.4293, height: reader.size.height * 0.1908)
                                    .foregroundColor(Color(#colorLiteral(red: 0.7685593963, green: 0.7686710954, blue: 0.7685348988, alpha: 1)))
                                    .cornerRadius(22)
                                
                                VStack(alignment: .leading, spacing: 10){
                                    Text("📒 🙂")
                                    Text("loren ipsun hsjd ksdk jsdk sjd hsj hsnks jsnd hshdk shdnks hsdk shdks dhks")
                                }.padding(.horizontal,20)
                            }
                        }
                    }
                }
            }.padding(.horizontal,20)
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
