//
//  EmptyScheduledPostsCard.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 20/08/21.
//

import SwiftUI

struct EmptyScheduledPostsCard: View {
    var body: some View {
        HStack {
            VStack {
                Image("EmptyScheduledPostCircle")
                Text(NSLocalizedString("emptyScheduledPosts", comment: ""))
                    .bold()
                    .multilineTextAlignment(.center)
                    .font(.custom("SF Pro Display", size: 14))
                    .foregroundColor(Color.white)
            }
            .padding()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 24).foregroundColor(Color(UIColor.appLightGrey)))
    }
}

struct EmptyScheduledPostsCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                Spacer()
                EmptyScheduledPostsCard()
                Spacer()
            }
        }
    }
}
