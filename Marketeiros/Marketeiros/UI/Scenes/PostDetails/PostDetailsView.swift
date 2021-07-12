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
                        .fill(Color.secondary)
                        .frame(width: 390, height: 300)

                    if viewModel.states.inputImage != nil {
                        Image(uiImage: viewModel.states.inputImage!)
                            .resizable()
                            .frame(width: 390, height: 500)
                            .scaledToFit()
                    } else {
                        Text("Clice aqui para selecionar a imagem")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    viewModel.toggleImagePicker()
                }
                
                Spacer()
                
                HStack{
                    Text("Título")
                    Spacer()
                    
                    ZStack(alignment:.trailing){
                        TextField("Título do Post", text: viewModel.bindings.titlePost)
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
                        TextField("Legendas", text: viewModel.bindings.legendPost)
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
                        TextField("#", text: viewModel.bindings.hastagPost)
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
                        TextField("E-mail do convidado", text: viewModel.bindings.markedPost)
                            .padding()
                            .frame(width: 253, height: 50)
                            .background(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                            .cornerRadius(8)
                    }
                }.padding(.horizontal,20)

                HStack(){
                    Toggle("Agendar", isOn: viewModel.bindings.showGreeting)
                }
                .padding(20)
                
                VStack {
                    DatePicker(
                        "Agendar",
                        selection: viewModel.bindings.scheduleDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(Color(#colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1))))
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
        .alert(isPresented: viewModel.bindings.showingAlertView, content: {
            Alert(title: Text("\(viewModel.states.percentage)"))
        })
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

/*struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailsView(post: .T(uid: "", photoPath: "", title: "", description: "", hashtags: [""], markedAccountsOnPost: [""], dateOfPublishing: Date()), board: Board)
        }
    }
}
*/
