//
//  RootView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/27/24.
//

import SwiftUI
import OpenAPIURLSession

struct RootView: View {
    @StateObject private var navigation = NavigationViewModel()
    @StateObject private var appearance = AppearanceViewModel()
    @StateObject private var storiesViewModel = StoriesViewModel()
    @StateObject private var choosingDirectionViewModel = ChoosingDirectionViewModel()
    @StateObject private var citiesViewModel: CitiesViewModel
    @StateObject private var stationsViewModel: StationsViewModel
    @StateObject private var carriersViewModel: CarriersViewModel
    
    init() {
        let serverURL = try! Servers.server1()

        let authenticationMiddleware = AuthenticationMiddleware(
            apiKey: Constants.apiKey
        )
        
        var client: Client {
            Client(
                serverURL: serverURL,
                transport: URLSessionTransport(),
                middlewares: [authenticationMiddleware]
            )
        }
        
        _citiesViewModel = StateObject(
            wrappedValue: CitiesViewModel(
                nearestSettlementService: NearestSettlementService(client: client)
            )
        )
        
        _stationsViewModel = StateObject(
            wrappedValue: StationsViewModel(
                nearestStationsService: NearestStationsService(client: client)
            )
        )
        
        _carriersViewModel = StateObject(
            wrappedValue: CarriersViewModel(
                searchService: SearchService(client: client)
            )
        )
    }
    
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
            .environmentObject(storiesViewModel)
            .environmentObject(citiesViewModel)
            .environmentObject(stationsViewModel)
            .preferredColorScheme(appearance.colorScheme)
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    RootView()
}
