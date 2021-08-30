//
//  TestProfileSheet.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 24/08/21.
//

import SwiftUI

struct BottomSheetView<Placeholder: View, Sheet: View>: View {
    @Binding var offset: CGFloat
    @Binding var isCollpsed: Bool
    var content: Placeholder
    var sheet: Sheet
    
    init(offset: Binding<CGFloat>, isCollpsed: Binding<Bool>, @ViewBuilder content: () -> Placeholder,  @ViewBuilder sheet: () -> Sheet) {
        self.content = content()
        self.sheet = sheet()
        self._offset = offset
        self._isCollpsed = isCollpsed
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            
            VStack{
                if !isCollpsed {
                    BlurView(style: .light)
                        .transition(.opacity)
                        .onTapGesture {
                            toggleBottomSheet()
                        }
                }
            }
            
            sheet
                .ignoresSafeArea(.container,edges: .bottom)
                .frame(height: offset)
                .padding(.horizontal,1)
        }.ignoresSafeArea(.container,edges: .bottom)
    }
    
    func toggleBottomSheet() {
        withAnimation {
            offset = isCollpsed ? 500 : 0
            isCollpsed.toggle()
        }
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(offset: .constant(0), isCollpsed: .constant(true), content: {
            VStack {
                Button(action: {
                   
                }, label: {
                    HStack{
                        Spacer()
                        Text("Button")

                        Spacer()
                    }
                })
                Spacer()
            }
            .background(Color(.red)) 
        }, sheet: {
            ProfileSheet(boards: .constant(
                            [.init(uid: UUID().uuidString, imagePath: "", title: "Inspector", description: "", instagramAccount: "inspector", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: ""),
                            ]), board: .constant(.init(uid: UUID().uuidString, imagePath: "", title: "Inspector", description: "", instagramAccount: "inspector", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: "")), okButtonCallback: {})
        })
    }
}


// teste2
//struct TestProfileSheet<Placeholder: View>: View {
//    @Binding var offset: CGFloat
//    @Binding var isCollpsed: Bool
//    var content: () -> Placeholder
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            content()
//
//            VStack{
//                if !isCollpsed {
//                    BlurView(style: .light)
//                        .transition(.opacity)
//                        .onTapGesture {
//                            toggleBottomSheet()
//                        }
//                }
//            }
//
//            ProfileSheet(boards: .constant(
//                            [.init(uid: UUID().uuidString, imagePath: "", title: "Inspector", description: "", instagramAccount: "inspector", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: ""),
//                            ]), okButtonCallback: {toggleBottomSheet()})
//                .ignoresSafeArea(.container,edges: .bottom)
//                .frame(height: offset)
//                .padding(.horizontal,1)
//        }.ignoresSafeArea(.container,edges: .bottom)
//    }
//
//    func toggleBottomSheet() {
//        withAnimation {
//            offset = isCollpsed ? 500 : 0
//            isCollpsed.toggle()
//        }
//    }
//}
//
//struct TestProfileSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        TestProfileSheet(offset: .constant(0), isCollpsed: .constant(true), content: {
//            VStack {
//                Button(action: {
//
//                }, label: {
//                    HStack{
//                        Spacer()
//                        Text("Button")
//
//                        Spacer()
//                    }
//                })
//                Spacer()
//            }
//            .background(Color(.red))
//        })
//    }
//}

// teste 1
//struct TestProfileSheet: View {
//    @State var offset: CGFloat = 0
//    @State var isCollpsed = true
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            // aqui vai ficar a view de background
//            VStack {
//                Button(action: {
//                    toggleBottomSheet()
//                }, label: {
//                    HStack{
//                        Spacer()
//                        Text("Button")
//
//                        Spacer()
//                    }
//                })
//                Spacer()
//            }
//            .background(Color(.red))
//            // até aqui
//
//            VStack{
//                if !isCollpsed {
//                    BlurView(style: .light)
//                        .transition(.opacity)
//                        .onTapGesture {
//                            toggleBottomSheet()
//                        }
//                }
//            }
//
//            ProfileSheet(boards: .constant(
//                            [.init(uid: UUID().uuidString, imagePath: "", title: "Inspector", description: "", instagramAccount: "inspector", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: ""),
//                            ]), okButtonCallback: {toggleBottomSheet()})
//                .ignoresSafeArea(.container,edges: .bottom)
//                .frame(height: offset)
//                .padding(.horizontal,1)
//        }.ignoresSafeArea(.container,edges: .bottom)
//    }
//
//    func toggleBottomSheet() {
//        withAnimation {
//            offset = isCollpsed ? 500 : 0
//            isCollpsed.toggle()
//        }
//    }
//}
//
//struct TestProfileSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        TestProfileSheet()
//
//    }
//}
