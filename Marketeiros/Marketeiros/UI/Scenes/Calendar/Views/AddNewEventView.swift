//
//  AddNewEventView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 18/06/21.
//

import SwiftUI

struct AddNewEventView: View {
    @State var title = ""
    @State var date = Date()
    @State var boardsExpanded = false
    @State var colaboratorsExpanded = false
    @State var colaborators = ["Fulana", "Fulano", "Ciclano"]
    
    var body: some View {
        VStack(spacing:20){
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom,5)
            
            HStack{
                Button(action: {
                    
                }, label: {
                    Text(NSLocalizedString("cancelBtn", comment: ""))
                        .foregroundColor(Color(#colorLiteral(red: 0.8705882353, green: 0.3647058824, blue: 0.3647058824, alpha: 1)))
                        .font(.body)
                })
                Spacer()
                Text(NSLocalizedString("newEvent", comment: ""))
                    .foregroundColor(Color("SheetHeaderColor"))
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text(NSLocalizedString("addEvent", comment: ""))
                        .foregroundColor(Color("SheetButton"))
                        .font(.body)
                })
            }
            
            VStack(alignment: .leading) {
                Text(NSLocalizedString("title", comment: ""))
                    .cellTitle()
                TextField("", text: $title)
                    .padding(.horizontal,10)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0566)
                    .foregroundColor(Color(#colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                    .background(Color("TextField2"))
                    .cornerRadius(8)
            }
            
            HStack {
                Text(NSLocalizedString("starts", comment: ""))
                    .cellTitle()
                DatePicker("", selection: $date)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0566)
                    .datePickerStyle(CompactDatePickerStyle())
                    //.background(Color("TextField2"))
            }
            
            HStack {
                Text(NSLocalizedString("ends", comment: ""))
                    .cellTitle()
                DatePicker("", selection: $date)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0566)
                    .datePickerStyle(CompactDatePickerStyle())
                
                    //.background(Color("TextField2"))
            }
            
            VStack(alignment: .leading) {
                Text(NSLocalizedString("place", comment: ""))
                    .cellTitle()
                TextField("", text: $title)
                    .padding(.horizontal,10)
                    .frame(height: UIScreen.main.bounds.size.height * 0.0566)
                    .foregroundColor(Color(#colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                    .background(Color("TextField2"))
                    .cornerRadius(8)
            }
            
            HStack {
                Text(NSLocalizedString("calendar", comment: ""))
                    .cellTitle()
                Spacer()
            }
            
            DisclosureGroup(
                isExpanded: $boardsExpanded,
                content: {
                    VStack() {
                        ForEach(colaborators, id: \.self) { colaborator in
                            HStack() {
                                Text(colaborator)
                                    .foregroundColor(Color(#colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                                    .padding(.vertical)
                                Spacer()
                            }
                        }
                    }
                    .padding(.top)
                },
                label: {
                    Text("Board 1")
                        .foregroundColor(Color(#colorLiteral(red: 0.6117647059, green: 0.6039215686, blue: 0.6862745098, alpha: 1)))
                        //.padding()
                })
                .padding()
                .background(Color("TextField2"))
                .cornerRadius(8)
                
//            HStack {
//                Text("Colaboradores")
//                    .cellTitle()
//                Spacer()
//            }
//
//            DisclosureGroup(
//                isExpanded: $colaboratorsExpanded,
//                content: {
//                    VStack() {
//                        ForEach(colaborators, id: \.self) { colaborator in
//                            HStack() {
//                                Text(colaborator)
//                                    .foregroundColor(.white)
//                                    .padding(.vertical)
//                                Spacer()
//                            }
//                        }
//                    }
//                    .padding(.top)
//                },
//                label: {
//                    Text("Board 1")
//                        .foregroundColor(.white)
//                        //.padding()
//                })
//                .padding()
//                .background(Color.red)
//                .cornerRadius(8)
//
          Spacer()
        }
        //.background(BlurView(style: .systemMaterial))
        //.ignoresSafeArea(edges:.bottom)
        
        .padding()
        
    }
}

struct AddNewEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewEventView()
    }
}
