//
//  CalendarPageView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 15/06/21.
//

import SwiftUI

struct CalendarPageView: View {
    @State private var date = Date()
    @State var offset : CGFloat = 0
    //let aux : CGFloat = 400
    let aux : CGFloat = UIScreen.main.bounds.height * 0.41
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            VStack {
                HStack {
                    Text("Calendar")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {}, label: {
                        Text("Add Event")
                            .foregroundColor(.white)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 10))
                    })
                }
                //.padding(.top,30)
                DatePicker("Eita", selection: $date, displayedComponents: .date).datePickerStyle(GraphicalDatePickerStyle())
            }.padding(.horizontal,25)
            
            GeometryReader { reader in
                VStack {
                    BottomSheet(offset: $offset, date: $date, value: (-reader.frame(in: .global).height + aux))
                        .offset(y: reader.frame(in: .global).height - aux)
                        .offset(y: offset) .gesture(DragGesture().onChanged({ (value) in
                            withAnimation {
                                if value.startLocation.y > reader.frame(in: .global).midX {
                                    if value.translation.height < 0 && offset > (-reader.frame(in: .global).height + aux) {
                                        offset = value.translation.height
                                    }
                                }
                                if value.startLocation.y < reader.frame(in: .global).midX {
                                    if value.translation.height > 0 && offset < 0 {
                                        offset = (-reader.frame(in: .global).height + aux) + value.translation.height
                                    }
                                }
                            }
                        }).onEnded({ (value) in
                            withAnimation {
                                if value.startLocation.y > reader.frame(in: .global).midX {
                                    if -value.translation.height > reader.frame(in: .global).midX {
                                        offset = (-reader.frame(in: .global).height + aux)
                                        return
                                    }
                                    offset = 0
                                }
                                if value.startLocation.y < reader.frame(in: .global).midX {
                                    if value.translation.height < reader.frame(in: .global).midX {
                                        offset = (-reader.frame(in: .global).height + aux)
                                        return
                                    }
                                    offset = 0
                                }
                            }
                        }))
                }
            }
        }
    }
}

struct CalendarPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalendarPageView()
        }
    }
}
