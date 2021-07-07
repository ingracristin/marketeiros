//
//  ProfileView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 15/06/21.
//

import SwiftUI
struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(){
            HStack(){
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancelar")
                    
                })
                Spacer()
                Text("tururu")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Ok")
                })
                
            }.padding()
            Button("Dismiss Modal") {
                
            }
            Spacer()
        }
    }
}

struct uh: View {
    @State private var isPresented = false

    var body: some View {
        Button("Present!") {
            isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented, content: FullScreenModalView.init)
    }
}
struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isShow = false
    @State private var showingPopover = false
    
    var body: some View {
        VStack() {
            HStack(alignment: .lastTextBaseline,spacing:0) {
                Spacer()
                Button(action: {
                    
                }) {
                    AppButtonView(label: "Sign Out") {
                        AuthService.current.signOut { result in
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .padding(.bottom,10)
            
            HStack {
                Text("Calendar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            
            HStack() {
                Image("bolinha")
                VStack() {
                    Text("Ingra Cristina")
                    Text("@ingracristicvn")
                }
                Spacer()
            }
            //.padding()
            
            VStack() {
                HStack() {
                    Text("Contas").font(.system(size: 24, weight: Font.Weight.bold, design: Font.Design.rounded))
                        
                    Spacer()
                    
                    Button(action: {}, label: {
                        Text("Add Event")
                            .foregroundColor(.white)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 10))
                            .accentColor(.gray)
                    })
                }
                //.padding(.horizontal)
                VStack(){
                    ForEach(0..<2, id:\.self){ index in 
                        AcountListCellSwiftUIView()
                    }
                }
                HStack(){
                    Text("Time").font(.system(size: 24, weight: Font.Weight.bold, design: Font.Design.rounded))
                    Image("i")
                        
                    Spacer()
                    Button(action: {
                        isShow.toggle()
                    }, label: {
                        Text("Add Event")
                            .foregroundColor(.white)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 10))
                            .accentColor(.gray)
                    })
                }
                //.padding(.horizontal)
                VStack(){
                    ForEach(0..<2, id:\.self){ index in
                        ListTeamsUIView()
                    }
                }
            }
            Spacer()
            Spacer()
        }
        .navigationTitle("Perfil")
        .sheet(isPresented: $isShow, content: {
            NewColaboratorSheet()
        })
        .padding(.horizontal,25)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView()
        }
    }
}
