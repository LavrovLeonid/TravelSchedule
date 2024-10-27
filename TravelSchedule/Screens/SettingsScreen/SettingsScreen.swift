//
//  SettingsScreen.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/27/24.
//

import SwiftUI

struct SettingsScreen: View {
    @State private var isDarkThemeEnabled = false
    
    var body: some View {
        VStack {
            Toggle("Темная тема", isOn: $isDarkThemeEnabled)
                .padding(16)
            HStack {
                Text("Пользовательское соглашение")
                Spacer()
                Image(.arrowForwardIcon)
            }.padding()
            Spacer()
        }
    }
}

#Preview {
    SettingsScreen()
}
