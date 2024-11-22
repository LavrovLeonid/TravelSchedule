//
//  SettingsScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/27/24.
//

import SwiftUI

struct SettingsScreenView: View {
    @EnvironmentObject private var navigation: NavigationViewModel
    @EnvironmentObject private var appearance: AppearanceViewModel
    
    var body: some View {
        VStack {
            Toggle("Темная тема", isOn: $appearance.isDarkMode)
                .padding(16)
                .tint(.travelBlue)
            ListItem(
                title: "Пользовательское соглашение"
            )
            .onTapGesture {
                navigation.push(screen: .agreements)
            }
            Spacer()
            Text("Приложение использует API «Яндекс.Расписания»")
                .font(.system(size: 12))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            Text("Версия \(Constants.appVersion) (beta)")
                .font(.system(size: 12))
                .padding(.bottom, 24)
        }
        .background(Color.travelWhite)
    }
}

#Preview {
    SettingsScreenView()
}
