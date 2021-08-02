//
//  DragRelocatreDelegate.swift
//  Marketeiros
//
//  Created by João Guilherme on 07/07/21.
//

import SwiftUI

struct DragRelocateDelegate: DropDelegate {
    let item: Post
    @Binding var listData: [Post]
    @Binding var current: Post?

    func dropEntered(info: DropInfo) {
        if item != current {
            let from = listData.firstIndex(of: current!)!
            let to = listData.firstIndex(of: item)!
            if listData[to].uid != current!.uid {
                //print(from,to)
                //print(listData)
                listData.move(fromOffsets: IndexSet(integer: from),
                    toOffset: to > from ? to + 1 : to)
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
    
    
}
