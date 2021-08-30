//
//  OnboardingP1.swift
//  Marketeiros
//
//  Created by João Guilherme on 25/08/21.
//

import SwiftUI

struct OnboardingP1: View {
    let text = NSLocalizedString("planOnboard", comment: "")
    
    var stringSplit : [String]{
        return text.split(separator: " ", maxSplits: 1).map(String.init)
    }
    @Binding var selection: Int
    
    
    var body: some View {
        Color(#colorLiteral(red: 0.9798260331, green: 0.9811581969, blue: 0.9283676147, alpha: 1))
            .ignoresSafeArea()
            .overlay(
                ZStack(alignment:.topTrailing){
                    VStack(alignment: .center, spacing: 20){
                        Image("Onboard1")
                            .resizable()
                            .edgesIgnoringSafeArea(.horizontal)
                            .frame(height: UIScreen.main.bounds.size.height * 0.6711)
                        
                        Group{
                            Text(stringSplit[0] + " ")
                                .font(Font.custom("cocon-bold",size: 24))
                                .fontWeight(.regular)
                                .foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.7254901961, blue: 0.2549019608, alpha: 1)))
                                + Text(stringSplit[1])
                                .font(Font.custom("cocon-bold",size: 24))
                                .fontWeight(.regular)
                                .foregroundColor(Color(#colorLiteral(red: 0.1921568627, green: 0.1803921569, blue: 0.4078431373, alpha: 1)))
                        }.frame(width:200)
                        .multilineTextAlignment(.center)
                        
                        Button(action: {
                            withAnimation{
                                self.selection += 1
                            }
                            
                        }, label: {
                            Text(NSLocalizedString("nextBtn", comment: ""))
                                .font(Font.custom("cocon-bold",size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                        })
                        .padding(.init(top: 12, leading: 42, bottom: 12, trailing: 42))
                        .background(Color(#colorLiteral(red: 0.2572367191, green: 0.3808146715, blue: 0.9349743724, alpha: 1)))
                        .cornerRadius(20)
                        
                        Spacer().frame(height:UIScreen.main.bounds.size.height * 0.0338)
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text(NSLocalizedString("skip", comment: ""))
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(Color(#colorLiteral(red: 0.2470588235, green: 0.2392156863, blue: 0.4274509804, alpha: 1)))
                    })
                    .offset(x: -20, y: 0)
                }
            )
        
        
    }
}

//struct OnboardingP1_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingP1(selection: <#Binding<Int>#>)
//    }
//}
