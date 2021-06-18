//
//  BottonSheetListCell.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 16/06/21.
//

import SwiftUI

struct BottonSheetListCell: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Color(.lightGray)
                .cornerRadius(21)
            HStack {
                VStack {
                    Spacer()
                    Text("17:00")
                    Spacer()
                }
                VStack {
                    Text("Titulo")
                        .cellTitle()
                        .fixedSize(horizontal: true, vertical: false)
                    Text("Titulo")
                        .cellSubTitle()
                    ColaboratorsView()
                }
                .padding()
            }
            .padding(.horizontal, 30)
        }
    }
}

struct ColaboratorsView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: -8) {
            Circle()
                .frame(width: 19, height: 19)
                .foregroundColor(.gray)
            Circle()
                .frame(width: 19, height: 19)
            Circle()
                .frame(width: 19, height: 19)
        }
    }
}

struct BottonSheetListCell_Previews: PreviewProvider {
    static var previews: some View {
        BottonSheetListCell()
    }
}
