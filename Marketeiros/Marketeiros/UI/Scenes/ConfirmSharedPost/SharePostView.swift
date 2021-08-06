//
//  SharePostView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 05/08/21.
//

import SwiftUI

struct SharePostView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: SharePostViewModel = SharePostViewModel()
    @Binding var scheduledNotification: ScheduledNotification
    
    var body: some View {
        VStack(spacing: 20) {
            HStack{
                Button(action: {
                    print("aaaa")
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(NSLocalizedString("cancelBtn", comment: ""))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(#colorLiteral(red: 0.8705882353, green: 0.3647058824, blue: 0.3647058824, alpha: 1)))
                        .font(.body)
                })
                Spacer()
                Text(NSLocalizedString("share", comment: ""))
                    .foregroundColor(Color(UIColor.navBarTitleColor))
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {

                }, label: {
                    Text(NSLocalizedString("save", comment: ""))
                        .foregroundColor(Color("SheetButton"))
                        .font(.body)
                }).isHidden(true)
            }.padding(.vertical)
            
            Image(uiImage: viewModel.getImage(of: $scheduledNotification.wrappedValue))
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width * 0.9066, height: UIScreen.main.bounds.size.height * 0.3756)
                .clipped()
                .cornerRadius(24)
            HStack {
                Text(scheduledNotification.description ?? "")
                    .multilineTextAlignment(.leading)
                    .font(.custom("SF Pro Display", size: 14))
                    .foregroundColor(Color("postText"))
                Spacer()
            }
            
            HStack {
                Text("#danca #conceito #verde")
                    .multilineTextAlignment(.leading)
                    .font(.custom("SF Pro Display", size: 14))
                    .foregroundColor(Color("postText"))
                    .padding(.leading,3)
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Spacer()
                VStack {
                    Text(NSLocalizedString("captionMessage", comment: ""))
                        .multilineTextAlignment(.center)
                        .font(.custom("SF Pro Display", size: 13))
                        .foregroundColor(Color("CaptionWarningForegroundColor"))
                        .padding(.leading,3)
                    Text(NSLocalizedString("captionTip", comment: ""))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .font(.custom("SF Pro Display", size: 13))
                        .foregroundColor(Color("CaptionWarningForegroundColor"))
                        .padding(.leading,3)
                }
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("CaptionWarningBackgroundCardColor")))
            .shadow(radius: 6)
            
            Spacer()
            Button(action: {
                viewModel.share(scheduledPost: scheduledNotification)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Label(
                        title: {
                            Text(NSLocalizedString("publishOnFeed", comment: ""))
                                .foregroundColor(.white)
                                .font(Font.coconBold(sized: 16)) },
                        icon: { Image("instagramLogo") })
                }
                .padding(.vertical, 10)
                .padding(.horizontal,15)
                .background(RoundedRectangle(cornerRadius: 20)
                                .accentColor(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1))))
            })
            Spacer()
        }.padding(.horizontal,20)
    }
}

struct SharePostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SharePostView(scheduledNotification: .constant(.init(uid: "", title: "", description: "wyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqw", boardUid: "", boardTitle: "", date: .init(), imagePath: "")))
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
        }
    }
}
