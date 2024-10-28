//
//  SettingsScreen.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/27/24.
//

import SwiftUI

enum SettingsPath: Hashable {
    case userAgreement
}

struct SettingsScreen: View {
    @State private var isDarkThemeEnabled = false
    @State private var path: [SettingsPath] = []
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $path) {
                VStack {
                    Toggle("Темная тема", isOn: $isDarkThemeEnabled)
                        .padding(16)
                    HStack {
                        Text("Пользовательское соглашение")
                        Spacer()
                        Image(.arrowForwardIcon)
                    }
                    .padding()
                    .onTapGesture {
                        path.append(.userAgreement)
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
                .navigationDestination(for: SettingsPath.self) { id in
                    if id == .userAgreement {
                        UserAgreementScreen()
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    SettingsScreen()
}
