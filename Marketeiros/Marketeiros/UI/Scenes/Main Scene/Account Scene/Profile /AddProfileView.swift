//
//  AddProfileView.swift
//  Marketeiros
//
//  Created by João Guilherme on 20/08/21.
//

import SwiftUI

struct AddProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AddProfileViewModel { _ in}
    
    var body: some View {
        ProgressBarView(isShowing: viewModel.bindings.alertViewShowing, value: viewModel.bindings.percentage) {
            VStack(alignment: .leading){
                ZStack {
                    HStack {
                        Spacer()
                        Text(NSLocalizedString("addProfile", comment: ""))
                            .foregroundColor(Color("NavBarTitle"))
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text(NSLocalizedString("cancelBtn", comment: ""))
                                .foregroundColor(Color(#colorLiteral(red: 0.8705882353, green: 0.3647058824, blue: 0.3647058824, alpha: 1)))
                                .font(.body)
                        })
                        Spacer()
                        Button(action: {
                            viewModel.createBoard { _ in
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            Text(NSLocalizedString("creatBtn", comment: ""))
                                .foregroundColor(Color("SheetButton"))
                                .font(.body)
                        })
                    }
                }
                HStack(){
                    Spacer()
                    Button(action: {
                        viewModel.toggleImagePicker()
                    }, label: {
                        if viewModel.states.inputImage == nil {
                            ZStack{
                                Image("perfil2")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.size.height * 0.0948, height: UIScreen.main.bounds.size.height * 0.0948)
                                
                                Image(systemName: "camera")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.size.height * 0.0295, height: UIScreen.main.bounds.size.height * 0.0233)
                                    .foregroundColor(Color("NavBarTitle"))
                                    .offset(x: 30, y: 30)
                            }
                        } else {
                            ZStack{
                                Image(uiImage: viewModel.states.inputImage!)
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.size.height * 0.0948, height: UIScreen.main.bounds.size.height * 0.0948)
                                    .clipShape(Circle())
                                
                                Image(systemName: "camera")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.size.height * 0.0295, height: UIScreen.main.bounds.size.height * 0.0233)
                                    .foregroundColor(Color("NavBarTitle"))
                                    .offset(x: 30, y: 30)
                            }
                        }
                    })
                    
                    Spacer()
                }
                
                Text(NSLocalizedString("profileName", comment: "")).fontWeight(.regular)
                    .font(.body)
                    .foregroundColor(Color("NavBarTitle"))
                
                TextField("", text: viewModel.bindings.title)
                    .padding()
                    .frame(width: UIScreen.main.bounds.size.width * 0.90, height: UIScreen.main.bounds.size.height * 0.0517)
                    .background(Color("TextField2"))
                    .cornerRadius(8)
                
                Text(NSLocalizedString("linkInsta", comment: "")).fontWeight(.regular)
                    .font(.body)
                    .foregroundColor(Color("NavBarTitle"))
                
                TextField(NSLocalizedString("PH_link", comment: ""), text: viewModel.bindings.instragramAccount)
                    .frame(height:UIScreen.main.bounds.size.height * 0.052)
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .background(Color("TextField2"))
                    .cornerRadius(8)
                Spacer()
            }
        }
        .padding(.horizontal,20)
        .sheet(isPresented: viewModel.bindings.showingImagePicker) {
            ImagePicker(image: viewModel.bindings.inputImage, imagePath: viewModel.bindings.photoPath)
        }
        .alert(isPresented: viewModel.bindings.errorAlertIsShowing, content: {
            Alert(title: Text(NSLocalizedString("Error", comment: "")), message: Text(viewModel.states.errorMessage), dismissButton: .cancel())
        })
    }
}

struct AddProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AddProfileView()
    }
}
