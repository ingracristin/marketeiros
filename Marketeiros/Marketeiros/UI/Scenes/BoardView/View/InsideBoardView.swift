//
//  InsideBoardView.swift
//  Marketeiros
//
//  Created by João Guilherme on 24/06/21.
//

import SwiftUI

struct InsideBoardView: View {
    @State var selectedView = 0
    
    let layout = [
        GridItem(.flexible(),spacing: 1),
        GridItem(.flexible(),spacing: 1),
        GridItem(.flexible(),spacing: 1)
    ]
    var body: some View {
        NavigationView{
            GeometryReader(){ reader in
                VStack(spacing: 20){
                    Picker("View", selection: $selectedView, content: {
                        Text("Grid").tag(0)
                        Text("Ideias").tag(1)
                        Text("Painel").tag(2)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    
                    ScrollView(){
                        LazyVGrid(columns: layout, spacing: 1){
                            ForEach(1...18, id: \.self){ _ in
                                Rectangle()
                                    .frame(height:reader.size.height * 0.15)
                                    .foregroundColor(Color(#colorLiteral(red: 0.9254091382, green: 0.9255421162, blue: 0.9253800511, alpha: 1)))
                                
                            }
                            
                        }
                    }
                    
                    
                    
                }.padding(.horizontal,20)
                
            }
            .navigationTitle("Board Um")
            .toolbar{
                ToolbarItemGroup(placement: .bottomBar){
                    Button(action: {}, label: {
                        Image(systemName: "plus").foregroundColor(.black)
                        
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "eyedropper").foregroundColor(.black)
                        
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "repeat").foregroundColor(.black)
                        
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "squareshape.split.3x3").foregroundColor(.black)
                        
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "trash").foregroundColor(.black)
                        
                    })
                }
            }
            
        }
    }

}

struct InsideBoardView_Previews: PreviewProvider {
    static var previews: some View {
        InsideBoardView()
    }
}
