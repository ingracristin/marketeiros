//
//  AddProfileView.swift
//  Marketeiros
//
//  Created by João Guilherme on 20/08/21.
//

import SwiftUI

struct AddProfileView: View {
    
    @State var profile = ""
    @State var insta = ""
    
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button(action: {
                    //presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(NSLocalizedString("cancelBtn", comment: ""))
                        .foregroundColor(Color(#colorLiteral(red: 0.8705882353, green: 0.3647058824, blue: 0.3647058824, alpha: 1)))
                        .font(.body)
                })
                Spacer()
                Text(NSLocalizedString("addProfile", comment: ""))
                    .foregroundColor(Color("NavBarTitle"))
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {
                    //                        viewModel.createBoard { _ in
                    //                            presentationMode.wrappedValue.dismiss()
                    //                        }
                }, label: {
                    Text(NSLocalizedString("creatBtn", comment: ""))
                        .foregroundColor(Color("SheetButton"))
                        .font(.body)
                })
            }
            HStack(){
                Spacer()
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
                Spacer()
            }
            
            Text(NSLocalizedString("profileName", comment: "")).fontWeight(.regular)
                .font(.body)
                .foregroundColor(Color("NavBarTitle"))
            
            TextField("", text: $profile)
                .padding()
                .frame(width: UIScreen.main.bounds.size.width * 0.90, height: UIScreen.main.bounds.size.height * 0.0517)
                .background(Color("TextField2"))
                .cornerRadius(8)
            
            Text(NSLocalizedString("linkInsta", comment: "")).fontWeight(.regular)
                .font(.body)
                .foregroundColor(Color("NavBarTitle"))
            
            TextField(NSLocalizedString("PH_link", comment: ""), text: $insta)
                .frame(height:UIScreen.main.bounds.size.height * 0.052)
                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                .background(Color("TextField2"))
                .cornerRadius(8)
            
            
            
        }.padding(.horizontal,20)
    }
}

struct AddProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AddProfileView()
    }
}
