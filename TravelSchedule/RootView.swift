//
//  RootView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/27/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            MainScreen()
                .tabItem {
                    Image(.mainTabIcon)
                        .renderingMode(.template)
                }
            SettingsScreen()
                .tabItem {
                    Image(.settingsTabIcon)
                        .renderingMode(.template)
                }
        }
        .tint(.travelBlack)
    }
}

#Preview {
    RootView()
}
