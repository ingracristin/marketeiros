//
//  PostDetailsView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 01/07/21.
//

import SwiftUI

struct PostDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PostDetailsViewModel
    
    init(post: Post, board: Board) {
        viewModel = .init(post: post, board: board)
    }
    
    var body: some View {
        ScrollView(){
            VStack(spacing: 10){
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(UIColor.emptyCellGridColor))
                        .frame(width: UIScreen.main.bounds.size.width * 0.9066, height: UIScreen.main.bounds.size.height * 0.3756)
                        .cornerRadius(24)

                    if viewModel.states.inputImage != nil {
                        Image(uiImage: viewModel.states.inputImage!)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width * 0.9066, height: UIScreen.main.bounds.size.height * 0.3756)
                            .scaledToFit()
                            .clipped()
                    } else {
                        VStack{
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.size.width * 0.1413, height: UIScreen.main.bounds.size.height * 0.0529)
                            Text("Adicione uma capa")
                        }.foregroundColor(Color(#colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                        
                    }
                }
                .onTapGesture {
                    viewModel.toggleImagePicker()
                }
                
                Spacer()
                
                HStack{
                    Text("Título")
                        .font(.title3)
                        .foregroundColor(Color("NavBarTitle"))
                    Spacer()
                    
                    ZStack(alignment:.trailing){
                        TextField("Um título faz a diferença", text: viewModel.bindings.titlePost)
                            .padding()
                            .frame(width: 253, height: 50)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                           
                    }
                }.padding(.horizontal,20)
                
                HStack{
                    Text("Legenda")
                        .font(.title3)
                        .foregroundColor(Color("NavBarTitle"))
                    Spacer()
                    ZStack(alignment:.trailing){
                        TextField("A legenda é fundamental...", text: viewModel.bindings.legendPost)
                            .padding()
                            //.frame(height:reader.size.height * 0.052)
                            .frame(width: 253, height: 100)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                    }
                }.padding(.horizontal,20)
                
                HStack{
                    Text("Hastags")
                        .font(.title3)
                        .foregroundColor(Color("NavBarTitle"))
                    Spacer()
                    ZStack(alignment:.trailing){
                        TextField("#", text: viewModel.bindings.hastagPost)
                            .padding()
                            .frame(width: 253, height: 50)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                    }
                }.padding(.horizontal,20)
                
                HStack{
                    Text("Marcados")
                        .font(.title3)
                        .foregroundColor(Color("NavBarTitle"))
                    Spacer()
                    ZStack(alignment:.trailing){
                        TextField("@", text: viewModel.bindings.markedPost)
                            .padding()
                            .frame(width: 253, height: 50)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                    }
                }.padding(.horizontal,20)

                HStack(){
                    Text("Agendar")
                        .font(.title3)
                        .foregroundColor(Color("NavBarTitle"))
                    Toggle("", isOn: viewModel.bindings.showGreeting)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                .padding(20)
                
                VStack {
                    DatePicker(
                        "Agendar",
                        selection: viewModel.bindings.scheduleDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(Color("TextField2"))
                                        .foregroundColor(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                        .isHidden(!viewModel.states.showGreeting)
                }
                .frame(height: (viewModel.states.showGreeting) ? CGFloat(350) : 0.0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .animation(.easeOut)
                .padding()
            }
        }
        .navigationBarTitle("Visualizar Post", displayMode: .inline)
        .padding(.vertical,20)
        .sheet(isPresented: viewModel.bindings.showingImagePicker, onDismiss: viewModel.loadImage) {
            ImagePicker(image: viewModel.bindings.inputImage, imagePath: viewModel.bindings.imagePath)
        }
        .navigationBarItems(trailing:
            Button(action: {
                viewModel.saveChangesToPost { _ in
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Salvar")
                    .font(Font.sfProDisplaySemiBold(sized: 17))
                    .foregroundColor(Color(UIColor.navBarItemsColor))
                    .font(.body)
            }))
    }
}

struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailsView(post: .T(uid: "", photoPath: "", title: "", description: "", hashtags: [""], markedAccountsOnPost: [""], dateOfPublishing: Date()), board: Board(uid: "", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
        }
    }
}

