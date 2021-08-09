//
//  AppMenuButton.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 01/08/21.
//

import SwiftUI

struct BoardMenuButton: View {
    var editAction: () -> ()
    var deleteAction: () -> ()
    var body: some View {
        Menu {
            Button {
                editAction()
            } label: {
                Label(NSLocalizedString("edit", comment: ""), systemImage: "square.and.pencil")
            }
            Button {
                deleteAction()
            } label: {
                Label(NSLocalizedString("justDelete", comment: ""), systemImage: "trash")
                    .foregroundColor(.red)
            }
        } label: {
            Image(systemName: "ellipsis")
        }
    }
}

struct BoardMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        BoardMenuButton(editAction: {}, deleteAction: {})
    }
}
