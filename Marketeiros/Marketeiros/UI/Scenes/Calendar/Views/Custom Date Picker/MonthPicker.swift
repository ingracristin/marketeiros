//
//  MonthYearPickerButton.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 21/07/21.
//

import SwiftUI

struct MonthYearPickerButton: View {
    @EnvironmentObject var monthDataModel: AppDatePickerViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        Button( action: {
            withAnimation {
                isPresented.toggle()
            }
        }) {
            HStack {
                Text(monthDataModel.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(UIColor.navBarTitleColor))
                Image(systemName: "chevron.right")
                    .rotationEffect(self.isPresented ? .degrees(90) : .degrees(0))
                    .foregroundColor(Color(UIColor.navBarTitleColor))
            }
        }
    }
}

struct MonthYearPickerButton_Previews: PreviewProvider {
    static var previews: some View {
        MonthYearPickerButton(isPresented: .constant(false))
    }
}
