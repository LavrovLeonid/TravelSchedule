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
    @StateObject private var viewModel = StationsViewModel()
    
    var body: some View {
        VStack {
            SearchBar(
                searchText: $viewModel.searchText,
                isSearching: true,
                placeholder: "Введите запрос"
            )
            if !viewModel.searchText.isEmpty,
               viewModel.filteredStations.isEmpty {
                Spacer()
                VStack {
                    Text("Станция не найдена")
                        .font(.system(size: 24, weight: .bold))
                        .tint(Color.travelBlack)
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.filteredStations) { station in
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
        .background(Color.travelWhite)
        .navigationTitle("Выбор станции")
        .navigationBarBackButtonTitleHidden()
    }
}

#Preview {
    StationsScreenView()
}
