//
//  PostDetailsView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 01/07/21.
//

import SwiftUI

struct PostDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: PostDetailsViewModel
    @State var value : CGFloat = 0
    var firstTouch = true
    @State var heightText: CGFloat = UIScreen.main.bounds.size.height * 0.1231
    @State var lineNumbers = 0
    @State var lastLineNumbers = 0
    
    init(post: Post, board: Board) {
        _viewModel = StateObject(wrappedValue: .init(post: post, board: board))
    }
    
    var body: some View {
        LoadingPost(isShowing: viewModel.bindings.showingAlertView) {
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
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.size.width * 0.9066, height: UIScreen.main.bounds.size.height * 0.3756)
                                .clipped()
                                .cornerRadius(24)
                        } else {
                            VStack{
                                Image(systemName: "camera")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.size.width * 0.1413, height: UIScreen.main.bounds.size.height * 0.0529)
                                Text(NSLocalizedString("chooseImg", comment: ""))
                            }//.foregroundColor(Color( colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                        }
                    }
                    .onTapGesture {
                        viewModel.toggleImagePicker()
                    }
                    
                    VStack(alignment: .leading){
                        
                        Text(NSLocalizedString("caption", comment: "")).fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color("NavBarTitle"))

                            TextEditor(text: viewModel.bindings.legendPost)
                                .disableAutocorrection(true)
                                .padding()
                                //.frame(height:reader.size.height * 0.052)
                                .frame(width: UIScreen.main.bounds.size.width * 0.90, height: heightText)
                                .background(Color("TextField2"))
                                .cornerRadius(8)
                                .onChange(of: viewModel.bindings.legendPost.wrappedValue, perform: {text in
                                    self.lineNumbers = text.components(separatedBy: "\n").count
                                    
                                    if(lineNumbers > lastLineNumbers){
                                        heightText += 10
                                        lastLineNumbers = lineNumbers
                                    }
                                })
                        
                        Spacer().frame(height: UIScreen.main.bounds.size.height * 0.0184)
                                    
                        Text("Hashtags")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color("NavBarTitle"))
                        
                        TextField("#", text: viewModel.bindings.hastagPost)
                            .disableAutocorrection(true)
                            .padding()
                            .frame(width: UIScreen.main.bounds.size.width * 0.90, height: UIScreen.main.bounds.size.height * 0.0517)
                            .background(Color("TextField2"))
                            .cornerRadius(8)
                        
                        Spacer().frame(height: UIScreen.main.bounds.size.height * 0.0184)
                        
                        Text(NSLocalizedString("identi", comment: "")).fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color("NavBarTitle"))
                            TextField(NSLocalizedString("PH_title", comment: ""), text: viewModel.bindings.titlePost)
                                .disableAutocorrection(true)
                                .padding()
                                .frame(width: UIScreen.main.bounds.size.width * 0.90, height: UIScreen.main.bounds.size.height * 0.0517)
                                .background(Color("TextField2"))
                                .cornerRadius(8)
                        
                    }.padding(.horizontal,20)
//                    HStack{
//                        Text(NSLocalizedString("tagPeople", comment: "")).fontWeight(.regular)
//                            .font(.body)
//                            .foregroundColor(Color("NavBarTitle"))
//
//                        Spacer()
//                        ZStack(alignment:.trailing){
//                            TextField("@", text: viewModel.bindings.markedPost)
//                                .padding()
//                                .frame(width: UIScreen.main.bounds.size.width * 0.6746, height: UIScreen.main.bounds.size.height * 0.0517)
//                                .background(Color("TextField2"))
//                                .cornerRadius(8)
//                        }
//                    }.padding(.horizontal,20)
                    
                    HStack(){
                        Text(NSLocalizedString("schedule", comment: "")).fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color("NavBarTitle"))
                        Toggle("", isOn: viewModel.bindings.showGreeting)
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                    }
                    .padding(20)
                    
                    VStack{
                        DatePicker(
                            "Agendar",
                            selection: viewModel.bindings.scheduleDate,
                            in: Date()...)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                            .background(Color("TextField2"))
                            //.foregroundColor(Color( colorLiteral(red: 0.7371894717, green: 0.7372970581, blue: 0.7371658683, alpha: 1)))
                            .isHidden(!viewModel.states.isShowingDatePicker)
                    }.frame(height: (viewModel.states.isShowingDatePicker) ? CGFloat(350) : 0.0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .animation(.easeOut)
                    .padding((viewModel.states.isShowingDatePicker) ? 18 : 0)
                    //.cornerRadius(8)
                    
                    Button(action: {
                        viewModel.publishNow()
                    }, label: {
                        HStack {
                            Spacer()
                            Text(NSLocalizedString("publishNow", comment: ""))
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.vertical,12)
                        .background(RoundedRectangle(cornerRadius: 18)
                                        .accentColor(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1))))
                    })
                    .padding()
                    .padding(.bottom,18)
                    
                    Button(action:{
                        viewModel.setErrorAlertIsShowing(true)
                    }, label: {
                        Text(NSLocalizedString("deletePost", comment: ""))
                            .font(.body)
                            .foregroundColor(.red)
                    })
                }
                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                .offset(y: -self.value)
            }
            .navigationBarTitle(NSLocalizedString("createPost", comment: ""), displayMode: .inline)
            .padding(.vertical,20)
            .sheet(isPresented: viewModel.bindings.showingImagePicker, onDismiss: viewModel.loadImage) {
                ImagePicker(image: viewModel.bindings.inputImage, imagePath: viewModel.bindings.imagePath)
            }
            .onAppear {
                UserNotificationService.shared.askUserNotificationPermission()
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (noti) in
                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.value = height
                }
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (noti) in
                    self.value = 0
                }
                
                UIApplication.shared.addTapGestureRecognizer()
            }
            .navigationBarItems(trailing:
                    Button(action: {
                        viewModel.saveChangesToPost { _ in
                            presentationMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        Text(NSLocalizedString("save", comment: ""))
                            .font(.body)
                       
                    }))
                    /**/
            .alert(isPresented: viewModel.bindings.errorAlertIsShowing, content: {
                Alert(title: Text(viewModel.states.errorMessage), primaryButton: .default(Text(NSLocalizedString("yes", comment: "")), action: {
                    viewModel.deletePost()
                    presentationMode.wrappedValue.dismiss()
                }), secondaryButton: .cancel(Text(NSLocalizedString("no", comment: ""))))
            })
        }
    }
}

struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailsView(post: .T(uid: "", photoPath: "", title: "", description: "", hashtags: [""], markedAccountsOnPost: [""], dateOfPublishing: Date()), board: Board(uid: "", imagePath: "", title: "", description: "", instagramAccount: "", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: ""))
        }
    }
}

