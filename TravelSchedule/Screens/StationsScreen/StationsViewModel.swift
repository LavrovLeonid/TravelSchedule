//
//  StationsViewModel.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/15/24.
//

import Combine

final class StationsViewModel: ObservableObject {
    var stations: [Station] = [
        Station(name: "Киевский вокзал"),
        Station(name: "Курский вокзал"),
        Station(name: "Ярославский вокзал"),
        Station(name: "Белорусский вокзал"),
        Station(name: "Савеловский вокзал"),
        Station(name: "Ленинградский вокзал")
    ]
    
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                filteredStations = stations
            } else {
                filteredStations = stations.filter { $0.name.contains(searchText) }
            }
        }
    }
    @Published var filteredStations: [Station] = []
    
    init() {
        filteredStations = stations
    }
}
