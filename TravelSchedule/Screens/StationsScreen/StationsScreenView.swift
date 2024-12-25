//
//  StationsScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/15/24.
//

import SwiftUI

struct StationsScreenView: View {
    @EnvironmentObject private var choosingDirectionViewModel: ChoosingDirectionViewModel
    @EnvironmentObject private var navigation: NavigationViewModel
    @EnvironmentObject private var stationsViewModel: StationsViewModel
    
    var body: some View {
        VStack {
            switch stationsViewModel.errorType {
                case .some(let errorType):
                    ErrorScreenView(errorType: errorType)
                case .none:
                    SearchBar(
                        searchText: $stationsViewModel.searchText,
                        isSearching: true,
                        placeholder: "Введите запрос"
                    )
                    if !stationsViewModel.searchText.isEmpty,
                       stationsViewModel.filteredStations.isEmpty {
                        Spacer()
                        VStack {
                            Text("Станция не найдена")
                                .font(.system(size: 24, weight: .bold))
                                .tint(Color.travelBlack)
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(stationsViewModel.filteredStations) { station in
                                    ListItem(title: station.name)
                                        .onTapGesture {
                                            choosingDirectionViewModel.setStation(station)
                                            navigation.popToRoot()
                                        }
                                }
                            }
                        }
                    }
                    Spacer()
            }
        }
        .background(Color.travelWhite)
        .navigationTitle("Выбор станции")
        .navigationBarBackButtonTitleHidden()
        .task {
            switch choosingDirectionViewModel.direction {
                case .from:
                    guard let fromCity = choosingDirectionViewModel.fromCity else { return }
                    
                    await stationsViewModel.fetchStations(at: fromCity)
                case .to:
                    guard let toCity = choosingDirectionViewModel.toCity else { return }
                    
                    await stationsViewModel.fetchStations(at: toCity)
            }
        }
        .onDisappear {
            stationsViewModel.reset()
        }
    }
}

#Preview {
    StationsScreenView()
}
