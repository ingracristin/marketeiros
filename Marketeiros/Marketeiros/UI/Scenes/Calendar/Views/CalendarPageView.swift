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
    @State var isShowing = false
    //let aux : CGFloat = 400
    let aux : CGFloat = UIScreen.main.bounds.height * 0.35
    @ObservedObject var viewModel = CalendarPageViewModel()
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            Image("calendarBackgroundImage")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height * 0.09)
                .ignoresSafeArea()
            
            VStack(spacing:0) {
                HStack(alignment: .lastTextBaseline,spacing:0) {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .frame(height: 40)
                    }
                }.padding(.bottom,0)
                    
                HStack {
                    Text(NSLocalizedString("calendar", comment: ""))
                        .navBarTitle()
                    Spacer()
                    
//                    AppButtonView(
//                        label: NSLocalizedString("creatEventBtn", comment: "")) {
//                        isShowing.toggle()
//                    }
                }
                .padding(.bottom,8)
            
                DatePicker("Eita", selection: $date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .accentColor(Color(UIColor.appLightBlue))
            }
            .padding(.horizontal)
            
            GeometryReader { reader in
                VStack {
                    BottomSheet(offset: $offset, date: $date, notifications: viewModel.getWeekNotifications(of: date), value: (-reader.frame(in: .global).height + aux))
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
                        .ignoresSafeArea(.container, edges: .bottom)
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowing, content: {
            AddNewEventView()
        })
        .onAppear {
            viewModel.getScheduledNotifications()
        }
    }
}

struct CalendarPageView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            CalendarPageView()
        }
    }
}
