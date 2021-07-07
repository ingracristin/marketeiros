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
    }
}

struct NotificationsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NotificationsDetailsView()
        }
    }
}
