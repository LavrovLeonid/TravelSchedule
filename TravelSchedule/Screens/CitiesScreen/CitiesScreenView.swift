//
//  CitiesScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/11/24.
//

import SwiftUI

struct CitiesScreenView: View {
    @EnvironmentObject private var choosingDirectionViewModel: ChoosingDirectionViewModel
    @EnvironmentObject private var navigation: NavigationViewModel
    @StateObject private var viewModel = CitiesViewModel()
    
    var body: some View {
        VStack {
            SearchBar(
                searchText: $viewModel.searchText,
                isSearching: true,
                placeholder: "Введите запрос"
            )
            if !viewModel.searchText.isEmpty,
               viewModel.filteredCities.isEmpty {
                Spacer()
                VStack {
                    Text("Город не найден")
                        .font(.system(size: 24, weight: .bold))
                        .tint(Color.travelBlack)
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.filteredCities) { city in
                            ListItem(title: city.name)
                                .onTapGesture {
                                    choosingDirectionViewModel.setCity(city)
                                    navigation.push(screen: .stations)
                                }
                        }
                    }
                }
            }
            Spacer()
        }
        .background(Color.travelWhite)
        .navigationTitle("Выбор города")
        .navigationBarBackButtonTitleHidden()
    }
}

#Preview {
    CitiesScreenView()
}
