//
//  CreateIdeaSceneView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 07/07/21.
//

import SwiftUI

struct CreateIdeaSceneView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CreateIdeaSceneViewModel
    @State var offset: CGFloat = 0
    @State var isCollpsed: Bool = true
    @State var pasteOffset: CGFloat = 0
    @State var isSwipped: Bool = false
    
    func toggleBottomSheet() {
        withAnimation {
            offset = isCollpsed ? 350 : 0
            isCollpsed.toggle()
        }
    }
    
    init(board: Board, pastes: [Paste], completion: ((Idea) -> ())?) {
        self.viewModel = CreateIdeaSceneViewModel(board: board, pastes: pastes, completion:completion)
    }
    
    var body: some View {
        IdeasBottomSheetView(offset: $offset, isCollpsed: $isCollpsed) {
            VStack {
                HStack {
                    Button(action: {
                        UIApplication.shared.endEditing()
                        toggleBottomSheet()
                        //viewModel.togglePasteSheet()
                    }, label: {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color("NavBarTitle"))
                            Spacer()
                        }
                    }).padding(.vertical)
                    .frame(width:50)
                    Spacer()
                }
                
                TextField(NSLocalizedString("title", comment: ""), text: viewModel.bindings.title)
                    .foregroundColor(Color(UIColor.lightGray))
                    .font(Font.sfProDisplaySemiBold(sized: 26))
                    .onTapGesture {
                        viewModel.okButtonIsShowing(true)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        viewModel.okButtonIsShowing(false)
                    }
                TextEditor(text: viewModel.bindings.description)
                    .foregroundColor(Color(UIColor.lightGray))
                    .font(Font.sfProDisplaySemiBold(sized: 14))
                    .onTapGesture {
                        viewModel.okButtonIsShowing(true)
                        if viewModel.states.description == NSLocalizedString("descriptionIdea", comment: "") {
                            viewModel.setDescriptionwith(text: "")
                        }
                    }
            }.padding()
        } sheet: {
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Button(action: {
                        //viewModel.togglePasteSheet()
                        toggleBottomSheet()
                    }) {
                        Text(NSLocalizedString("cancel", comment: ""))
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Text(NSLocalizedString("Categorizar   ", comment: "")) //trad
                        .font(Font.sfProDisplaySemiBold(sized: 18))
                        .foregroundColor(Color(UIColor.navBarTitleColor))
                    Spacer()
                    Button(action: {
                        viewModel.togglePasteSheet()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                }.padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                VStack(spacing: 0){
                    ForEach(viewModel.pastes, id:\.uid) { paste in
                        ZStack {
                            HStack(spacing: 0){
                                Spacer()
                                Button(action: {}) {
                                    Image(systemName: "square.and.pencil")
                                        .foregroundColor(.white)
                                }.frame(width: UIScreen.main.bounds.size.width * 0.144, height: UIScreen.main.bounds.size.height * 0.0566)
                                .background(Color(#colorLiteral(red: 0.2733859122, green: 0.3903551698, blue: 0.9017891288, alpha: 1)))
                                Button(action: {}) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.white)
                                }.frame(width: UIScreen.main.bounds.size.width * 0.144, height: UIScreen.main.bounds.size.height * 0.0566)
                                .background(Color(#colorLiteral(red: 0.997802794, green: 0.2306014299, blue: 0.1866784096, alpha: 1)))
                            }
                            
                            
                            
                            
                            Button(action: {
                                viewModel.select(paste: paste)
                            }) {
                                HStack {
                                    
                                    Text(paste.title)
                                    Spacer()
                                    if (viewModel.states.paste.uid == paste.uid) {
                                        Image(systemName:"checkmark")
                                    }
                                }
                                .frame(height: UIScreen.main.bounds.size.height * 0.0566)
                                .background(Color("ModalSheetColor"))
                                .foregroundColor(Color(UIColor.navBarTitleColor))
                                
                            }.offset(x: pasteOffset)
                            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
                            
                        }.frame(height: UIScreen.main.bounds.size.height * 0.0566)
                        Divider()
                    }
                }
            }
            .padding(.horizontal,20)
            .background(CornerShapeView(corners: [.topLeft,.topRight], radius: 30).foregroundColor(Color("ModalSheetColor")))
            
            
            
        }
        .navigationBarTitle(NSLocalizedString("ideas", comment: ""),displayMode: .inline)
        .navigationBarItems(trailing:
                                HStack(spacing:20) {
                                    if viewModel.states.okButtonShowing {
                                        Button {
                                            viewModel.saveIdea(finish: {
                                                self.presentationMode.wrappedValue.dismiss()
                                            })
                    
                                        } label: {
                                            Text("ok")
                                                .fontWeight(.semibold)
                                        }
                                    }
                                }
        )
        
        
    }
    func onChanged(value: DragGesture.Value){
        
        if value.translation.width < 0{
            if(isSwipped){
                pasteOffset = value.translation.width - 90
            }else{
                pasteOffset = value.translation.width
            }
            
        }
    }
    
    func onEnd(value: DragGesture.Value){
        
        withAnimation(.easeOut){
            if(value.translation.width < 0){
                if(-value.translation.width > UIScreen.main.bounds.width / 2){
                    pasteOffset = -1000
                }else if(-pasteOffset > 50){
                    isSwipped = true
                    pasteOffset = -90
                }else{
                    isSwipped = false
                    pasteOffset = 0
                }
            }else{
                isSwipped = false
                pasteOffset = 0
            }
        }
        
    }
}

struct CreateIdeaSceneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateIdeaSceneView(board: .init(uid: "_guicf", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [""], postsGridUid: "", ideasGridUid: "", moodGridUid: ""), pastes: [.init(uid: "", title: "teu cu", icon: "")], completion: nil)
        }
    }
}
