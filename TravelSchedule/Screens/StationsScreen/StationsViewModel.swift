//
//  StationsViewModel.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/15/24.
//

import Foundation

@MainActor
final class StationsViewModel: ObservableObject {
    private let nearestStationsService: NearestStationsServiceProtocol
    
    var stations: [Station] = []
    
    @Published var searchText: String = "" {
        didSet {
            updateFilteredStations()
        }
    }
    @Published var filteredStations: [Station] = []
    @Published var errorType: ErrorType?
    
    init(nearestStationsService: NearestStationsServiceProtocol) {
        self.nearestStationsService = nearestStationsService
    }
    
    func fetchStations(at city: City) async {
        do {
            let response = try await nearestStationsService.getNearestStations(
                lat: city.coordinate.latitude,
                lng: city.coordinate.longitude,
                distance: Constants.nearestDistanceLimit,
                limit: 1000
            )
            
            stations = response.stations?.compactMap { station in
                guard
                    let code = station.code,
                    let title = station.title,
                    let latitude = station.lat,
                    let longitude = station.lng
                else { return nil }
                
                return Station(
                    code: code,
                    name: title,
                    coordinate: .init(latitude: latitude, longitude: longitude)
                )
            } ?? []
            
            updateFilteredStations()
        } catch ClientError.noConnection {
            errorType = .noConnection
        } catch {
            errorType = .server
        }
    }
    
    func reset() {
        stations = []
        errorType = nil
        updateFilteredStations()
    }
    
    private func updateFilteredStations() {
        if searchText.isEmpty {
            filteredStations = stations
        } else {
            filteredStations = stations.filter { $0.name.contains(searchText) }
        }
    }
}
