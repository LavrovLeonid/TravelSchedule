//
//  CitiesScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/11/24.
//

import SwiftUI
import OpenAPIURLSession

struct CitiesScreenView: View {
    @EnvironmentObject private var choosingDirectionViewModel: ChoosingDirectionViewModel
    @EnvironmentObject private var navigation: NavigationViewModel
    @EnvironmentObject private var citiesViewModel: CitiesViewModel
    
    var body: some View {
        VStack {
            switch citiesViewModel.errorType {
                case .some(let errorType):
                    ErrorScreenView(errorType: errorType)
                case .none:
                    SearchBar(
                        searchText: $citiesViewModel.searchText,
                        isSearching: true,
                        placeholder: "Введите запрос"
                    )
                    if !citiesViewModel.searchText.isEmpty,
                       citiesViewModel.filteredCities.isEmpty {
                        Spacer()
                        VStack {
                            Text("Город не найден")
                                .font(.system(size: 24, weight: .bold))
                                .tint(Color.travelBlack)
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(citiesViewModel.filteredCities) { city in
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
        }
        .background(Color.travelWhite)
        .navigationTitle("Выбор города")
        .navigationBarBackButtonTitleHidden()
        .task {
            await citiesViewModel.fetchCities()
        }
        .onDisappear {
            citiesViewModel.reset()
        }
    }
}

#Preview {
    CitiesScreenView()
}
