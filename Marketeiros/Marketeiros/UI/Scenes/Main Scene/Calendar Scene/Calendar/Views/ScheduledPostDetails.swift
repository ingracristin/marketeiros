//
//  ScheduledPostDetails.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 17/08/21.
//

import SwiftUI

struct ScheduledPostDetails: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: SharePostViewModel = SharePostViewModel()
    @Binding var scheduledNotification: ScheduledNotification
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(uiImage: viewModel.getImage(of: $scheduledNotification.wrappedValue))
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width * 0.9066, height: UIScreen.main.bounds.size.height * 0.3756)
                .clipped()
                .cornerRadius(24)
            HStack {
                Text(scheduledNotification.description)
                    .multilineTextAlignment(.leading)
                    .font(.custom("SF Pro Display", size: 14))
                    .foregroundColor(Color("postText"))
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Spacer()
                VStack {
                    Text("\(NSLocalizedString("hey", comment: "")) \(Text(NSLocalizedString("calendarPostScheduled", comment: "")).fontWeight(.bold).foregroundColor(Color("CaptionWarningForegroundColor"))) \(NSLocalizedString("calendarPostDetailsBox", comment: ""))")
                        .multilineTextAlignment(.center)
                        .font(.custom("SF Pro Display", size: 13))
                        .foregroundColor(Color("captionMessageColor"))
                        .padding(.leading,3)
                }
                Spacer()
                    
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("CaptionWarningBackgroundCardColor")))
            .shadow(radius: 6)
            
            Spacer()
            Button(action: {
                UserNotificationService.shared.deleteNotificationWith(uids: [scheduledNotification.uid])
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

struct ScheduledPostDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScheduledPostDetails(scheduledNotification: .constant(.init(uid: "", title: "", description: "wyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqwwyegqwueygqweqw \n#andias #sbdausybd", boardUid: "", boardTitle: "", date: .init(), imagePath: "")))
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
        }
        .preferredColorScheme(.light)
    }
}
