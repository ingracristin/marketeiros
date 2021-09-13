//
//  EditProfileView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 01/09/21.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var insideViewModel: InsideBoardViewModel
    @StateObject var viewModel: EditProfileViewModel
    @State var isLoading = false
    
    init(board: Board,callback: @escaping (Board) -> () ) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(board: board, callback: callback))
    }
    
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ProgressBarView(isShowing: viewModel.bindings.alertViewShowing, value: viewModel.bindings.percentage) {
                VStack(alignment: .leading){
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text(NSLocalizedString("cancelBtn", comment: ""))
                                .foregroundColor(Color(#colorLiteral(red: 0.8705882353, green: 0.3647058824, blue: 0.3647058824, alpha: 1)))
                                .font(.body)
                        })
                        Spacer()
                        Text(NSLocalizedString("editProfile", comment: ""))
                            .foregroundColor(Color("NavBarTitle"))
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                        Button(action: {
                            viewModel.saveChangesToBoard()
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text(NSLocalizedString("save", comment: ""))
                                .foregroundColor(Color("SheetButton"))
                                .font(.body)
                        })
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
                    HStack {
                        Spacer()
                        Button(action: {
                            isLoading.toggle()
                            insideViewModel.delete(board: viewModel.board, completion: { _ in
                                self.isLoading.toggle()
                                presentationMode.wrappedValue.dismiss()
                            })
                        }, label: {
                            Text(NSLocalizedString("delete", comment: ""))
                        })
                        Spacer()
                    }
                    .foregroundColor(.red)
                    .padding()
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
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(board: Board.init(
                            uid: "",
                            imagePath: "",
                            title: "Plani Board",
                            description: "",
                            instagramAccount: "",
                            ownerUid: "",
                            colaboratorsUids: [],
                            postsGridUid: "",
                            ideasGridUid: "",
                            moodGridUid: ""), callback: {_ in})
    }
}
