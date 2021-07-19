//
//  NewBoardSheet.swift
//  Marketeiros
//
//  Created by João Guilherme on 18/06/21.
//

import SwiftUI

struct NewBoardSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel : NewBoardViewModel
    
    init(callback: @escaping (Board) -> ()) {
        viewModel = NewBoardViewModel(callback: callback)
    }
    
    var body: some View {
        ProgressBarView(isShowing: viewModel.bindings.alertViewShowing, value: viewModel.bindings.percentage) {
            
            ScrollView{
                VStack(alignment: .center ,spacing:25){
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 50, height: 5)
                        .padding(.top)
                        .padding(.bottom,5)
                    
                    HStack{
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text(NSLocalizedString("cancelBtn", comment: ""))
                                .foregroundColor(Color(#colorLiteral(red: 0.8705882353, green: 0.3647058824, blue: 0.3647058824, alpha: 1)))
                                .font(.body)
                        })
                        Spacer()
                        Text(NSLocalizedString("sheetTittleNew", comment: ""))
                            .foregroundColor(Color("SheetHeaderColor"))
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
                    VStack(alignment:.leading, spacing: UIScreen.main.bounds.size.height * 0.02){
                        HStack(spacing: 0){
                            Text(NSLocalizedString("nameBoard", comment: "")).fontWeight(.regular)
                                .font(.title3)
                                .foregroundColor(Color("NavBarTitle"))
                            
                            Spacer()
                        }
                        TextField(NSLocalizedString("PH_boardName", comment: ""), text: viewModel.bindings.title)
                            .frame(height:UIScreen.main.bounds.size.height * 0.052)
                            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                    }
                    
                    VStack(alignment:.leading, spacing: UIScreen.main.bounds.size.height * 0.02){
                        HStack(spacing: 0){
                            Text(NSLocalizedString("linkInsta", comment: "")).fontWeight(.regular)
                                .font(.title3)
                                .foregroundColor(Color("NavBarTitle"))
                            Spacer()
                        }
                        TextField(NSLocalizedString("PH_link", comment: ""), text: viewModel.bindings.instragramAccount)
                            .frame(height:UIScreen.main.bounds.size.height * 0.052)
                            .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                    }
                    
                    VStack(alignment:.leading, spacing: UIScreen.main.bounds.size.height * 0.02) {
                        Text(NSLocalizedString("boardBio", comment: "")).fontWeight(.regular)
                            .font(.title3)
                            .foregroundColor(Color("NavBarTitle"))
                        
                        TextField(NSLocalizedString("PH_boardbio", comment: ""),text: viewModel.bindings.description)
                            .frame(height: UIScreen.main.bounds.size.height * 0.1317,alignment: .topLeading)
                            .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
                            .multilineTextAlignment(.leading)
                            .background(Color("TextField2"))
                            .foregroundColor(Color(#colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                            .cornerRadius(8)
                    }
                    
                    VStack(alignment:.leading, spacing: UIScreen.main.bounds.size.height * 0.02){
                        Text(NSLocalizedString("imageBoard", comment: "")).fontWeight(.regular)
                            .font(.title3)
                            .foregroundColor(Color("NavBarTitle"))
                        Button(action: {
                            viewModel.toggleImagePicker()
                        }, label: {
                            ZStack(alignment: .center){
                                Rectangle()
                                    .foregroundColor(Color("TextField2"))
                                VStack {
                                    if viewModel.states.inputImage != nil {
                                        Image(uiImage: viewModel.states.inputImage!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.size.width * 0.90, height:UIScreen.main.bounds.size.height * 0.2512)
                                            .clipped()
                                        
                                    } else {
                                        Image(systemName: "camera")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.main.bounds.size.width * 0.1413, height: UIScreen.main.bounds.size.height * 0.0529)
                                        Text(NSLocalizedString("imageCaption", comment: ""))
                                    }
                                }.foregroundColor(Color(#colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                            }
                        })
                        .frame(height:UIScreen.main.bounds.size.height * 0.2512)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal,20)
                .sheet(isPresented: viewModel.bindings.showingImagePicker) {
                    ImagePicker(image: viewModel.bindings.inputImage, imagePath: viewModel.bindings.photoPath)
                }
            }
        }
    }
}

struct NewBoardSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewBoardSheet(callback: {_ in})
    }
}
