//
//  CitiesViewModel.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/11/24.
//

import SwiftUI

final class CitiesViewModel: ObservableObject {
    var cities: [City] = [
        City(name: "Москва"),
        City(name: "Санкт Петербург"),
        City(name: "Сочи"),
        City(name: "Горный воздух"),
        City(name: "Краснодар"),
        City(name: "Казань"),
        City(name: "Омск")
    ]
    
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                filteredCities = cities
            } else {
                filteredCities = cities.filter { $0.name.contains(searchText) }
            }
        }
    }
    @Published var filteredCities: [City] = []
    
    init() {
        filteredCities = cities
    }
}
