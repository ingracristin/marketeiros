//
//  CreatePostUIView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 25/06/21.
//

import SwiftUI

struct CreatePostUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CreatePostViewModel
    
    init(board: Board) {
        viewModel = .init(board: board)
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
                            .frame(width: 390, height: 500)
                            .scaledToFit()
                    } else {
                        VStack{
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.size.width * 0.1413, height: UIScreen.main.bounds.size.height * 0.0529)
                            Text(NSLocalizedString("chooseImg", comment: ""))
                        }.foregroundColor(Color(#colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                        
                        
                    }
                }
                .onTapGesture {
                    viewModel.toggleImagePicker()
                }
                
                Spacer()
                
                HStack{
                    Text("Título").fontWeight(.regular)
                        .font(.title3)
                        .foregroundColor(Color("NavBarTitle"))
                
                    Spacer()
                        
                    ZStack(alignment:.trailing){
                        TextField(NSLocalizedString("PH_title", comment: ""), text: viewModel.bindings.titlePost)
                            .padding()
                            .frame(width: 253, height: 50)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                    }
                }.padding(.horizontal,20)
                
                HStack{
                    Text(NSLocalizedString("caption", comment: "")).fontWeight(.regular)
                        .font(.title3)
                        .foregroundColor(Color("NavBarTitle"))
                
                    Spacer()
                    ZStack(alignment:.trailing){
                        TextField(NSLocalizedString("PH_caption", comment: ""), text: viewModel.bindings.legendPost)
                            .padding()
                            //.frame(height:reader.size.height * 0.052)
                            .frame(width: 253, height: 100)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                    }
                }.padding(.horizontal,20)
                
                HStack{
                    Text("Hastags").fontWeight(.regular)
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
                    Text(NSLocalizedString("tagPeople", comment: "")).fontWeight(.regular)
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
                    Text(NSLocalizedString("schedule", comment: "")).fontWeight(.regular)
                        .font(.title3)
                        .foregroundColor(Color("NavBarTitle"))
                    Toggle("", isOn: viewModel.bindings.showGreeting)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    
                }
                .padding(20)
                
                
                
                VStack {
                    DatePicker(
                        "Agendar",
                        selection: viewModel.bindings.scheduleDate,
                        in: Date()...)
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
        .navigationBarTitle(NSLocalizedString("createPost", comment: ""), displayMode: .inline)
        .padding(.vertical,20)
        .sheet(isPresented: viewModel.bindings.showingImagePicker, onDismiss: viewModel.loadImage) {
            ImagePicker(image: viewModel.bindings.inputImage, imagePath: viewModel.bindings.imagePath)
        }
        .alert(isPresented: viewModel.bindings.showingAlertView, content: {
            Alert(title: Text("\(viewModel.states.percentage)"))
        })
        .onAppear {
            viewModel.requestUserNotification()
        }
        .navigationBarItems(trailing: Button(action: {
            viewModel.addPostToBoard { _ in
                presentationMode.wrappedValue.dismiss()
            }
        }, label: {
            Text(NSLocalizedString("save", comment: ""))
                .font(Font.sfProDisplaySemiBold(sized: 17))
                .foregroundColor(Color(UIColor.navBarItemsColor))
                .font(.body)
        }))
    }
}

struct CreatePostUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreatePostUIView(board: .init(uid: "", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
        }
    }
}
