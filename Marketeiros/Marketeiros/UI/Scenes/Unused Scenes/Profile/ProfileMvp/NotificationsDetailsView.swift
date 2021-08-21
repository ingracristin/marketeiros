//
//  NotificationsDetailsView.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 07/07/21.
//

import SwiftUI

struct NotificationsDetailsView: View {
    @State private var changeFrame = true
    @State private var schedule = true
    @State private var calendar = true
    @State private var feedback = true
    var body: some View {
        VStack(spacing: 20) {
            Toggle("Alteração no quadro", isOn: $changeFrame)
            Toggle("Lembrete de agendamento", isOn: $schedule)
            Toggle("Lembrete do calendário", isOn: $calendar)
            Toggle("Recebimento de feedback", isOn: $feedback)
            Spacer()
        }.padding()
        .navigationBarTitle("Notifications", displayMode: .inline)
        .foregroundColor(Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)))
    }
}

struct NotificationsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NotificationsDetailsView()
        }
    }
}
