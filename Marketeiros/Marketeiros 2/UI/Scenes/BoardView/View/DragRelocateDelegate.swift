//
//  DragRelocatreDelegate.swift
//  Marketeiros
//
//  Created by João Guilherme on 07/07/21.
//

import SwiftUI

struct DragRelocateDelegate: DropDelegate {
    let item: Post
    @State var listData: [Post]
    @State var current: Post?

    func dropEntered(info: DropInfo) {
        if item != current {
            let from = listData.firstIndex(of: current!)!
            let to = listData.firstIndex(of: item)!
            if listData[to].uid != current!.uid {
                print(from,to)
                listData.move(fromOffsets: IndexSet(integer: from),
                    toOffset: to > from ? to + 1 : to)
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        print("updatou")
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
}
