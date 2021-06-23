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
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom,5)
            VStack(alignment: .leading) {
                Text("Titulo")
                    .cellTitle()
                TextField("", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("Começa em:")
                    .cellTitle()
                DatePicker("", selection: $date)
                    .datePickerStyle(CompactDatePickerStyle())
            }
            
            HStack {
                Text("Termina em:")
                    .cellTitle()
                DatePicker("", selection: $date)
                    .datePickerStyle(CompactDatePickerStyle())
            }
            
            VStack(alignment: .leading) {
                Text("Local")
                    .cellTitle()
                TextField("", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("Calendário")
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
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                Spacer()
                            }
                        }
                    }
                    .padding(.top)
                },
                label: {
                    Text("Board 1")
                        .foregroundColor(.white)
                        //.padding()
                })
                .padding()
                .background(Color.red)
                .cornerRadius(8)
                
            HStack {
                Text("Colaboradores")
                    .cellTitle()
                Spacer()
            }
            
            DisclosureGroup(
                isExpanded: $colaboratorsExpanded,
                content: {
                    VStack() {
                        ForEach(colaborators, id: \.self) { colaborator in
                            HStack() {
                                Text(colaborator)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                Spacer()
                            }
                        }
                    }
                    .padding(.top)
                },
                label: {
                    Text("Board 1")
                        .foregroundColor(.white)
                        //.padding()
                })
                .padding()
                .background(Color.red)
                .cornerRadius(8)
                
            Spacer()
        }
        //.background(BlurView(style: .systemMaterial))
        //.ignoresSafeArea(edges:.bottom)
        .cornerRadius(30)
        .padding()
    }
}

struct AddNewEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewEventView()
    }
}
