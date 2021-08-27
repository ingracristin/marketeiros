//
//  BottomSheetView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 25/08/21.
//

import SwiftUI

struct TestProfileSheet: View {
    @State var offset: CGFloat = 0
    @State var isCollpsed: Bool = true
    
    var body: some View {
        BottomSheetView(offset: $offset, isCollpsed: $isCollpsed) {
            VStack {
                Button(action: {
                    toggleBottomSheet()
                }, label: {
                    HStack{
                        Spacer()
                        Text("Button")

                        Spacer()
                    }
                })
                Spacer()
            }.background(Color(.red))
        } sheet: {
            ProfileSheet(boards: .constant(
                            [.init(uid: UUID().uuidString, imagePath: "", title: "Inspector", description: "", instagramAccount: "inspector", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: ""),
                            ]), board: .constant(.init(uid: UUID().uuidString, imagePath: "", title: "Inspector", description: "", instagramAccount: "inspector", ownerUid: "", colaboratorsUids: [], postsGridUid: "", ideasGridUid: "", moodGridUid: "")), okButtonCallback: {toggleBottomSheet()})
        }
    }
    
    func toggleBottomSheet() {
        withAnimation {
            offset = isCollpsed ? 500 : 0
            isCollpsed.toggle()
        }
    }
}

struct TestProfileSheet_Previews: PreviewProvider {
    static var previews: some View {
        TestProfileSheet()
    }
}

//struct BottomSheetView<Placeholder: View>: View {
//    let height: CGFloat
//    @State var offset: CGFloat
//    @State var isCollpsed: Bool
//    var content: () -> Placeholder
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            // aqui vai ficar a view de background
////            VStack {
////                Button(action: {
////                    toggleBottomSheet()
////                }, label: {
////                    HStack{
////                        Spacer()
////                        Text("Button")
////
////                        Spacer()
////                    }
////                })
////                Spacer()
////            }
////            .background(Color(.red))
//            // até aqui
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
//struct BottomSheetView_Previews: PreviewProvider {
//    @State static var isCollapsed: Bool = true
//    @State static var offset: CGFloat = 0
//
//    static var previews: some View {
//        BottomSheetView(height: 500, offset: offset, isCollpsed: isCollapsed,content: {
//            VStack {
//                Button(action: {
//                    withAnimation {
//                        offset = isCollapsed ? 500 : 0
//                        isCollapsed.toggle()
//                    }
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
//
//
//}
