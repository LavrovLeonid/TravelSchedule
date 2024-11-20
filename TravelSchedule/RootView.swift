//
//  RootView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/27/24.
//

import SwiftUI

struct RootView: View {
    @StateObject private var navigation = NavigationViewModel()
    @StateObject private var choosingDirectionViewModel = ChoosingDirectionViewModel()
    @StateObject private var carriersViewModel = CarriersViewModel()
    @StateObject private var appearance = AppearanceViewModel()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $navigation.path) {
                TabView {
                    MainScreenView()
                        .tabItem {
                            Image(.mainTabIcon)
                                .renderingMode(.template)
                        }
                    SettingsScreenView()
                        .tabItem {
                            Image(.settingsTabIcon)
                                .renderingMode(.template)
                        }
                }
                .tint(.travelBlack)
                .navigationDestination(
                    for: NavigationScreen.self
                ) { screen in
                    switch screen {
                        case .settings:
                            SettingsScreenView()
                        case .agreements:
                            UserAgreementScreenView()
                        case .cities:
                            CitiesScreenView()
                        case .stations:
                            StationsScreenView()
                        case .carriers:
                            CarriersScreenView()
                        case .carrier:
                            CarrierScreenView()
                        case .filters:
                            FiltersScreenView()
                    }
                }
                .background(Color.travelWhite)
            }
            .tint(Color.travelBlack)
            .background(Color.travelWhite)
            .environmentObject(navigation)
            .environmentObject(choosingDirectionViewModel)
            .environmentObject(carriersViewModel)
            .environmentObject(appearance)
            .preferredColorScheme(appearance.colorScheme)
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    RootView()
}
