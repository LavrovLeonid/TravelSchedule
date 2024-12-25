//
//  CitiesViewModel.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/11/24.
//

import Foundation
import OpenAPIURLSession

@MainActor
final class CitiesViewModel: ObservableObject {
    private let nearestSettlementService: NearestSettlementServiceProtocol
    
    private var cities: [City] = []
    
    @Published var searchText: String = "" {
        didSet {
            updateFilteredCities()
        }
    }
    @Published var filteredCities: [City] = []
    @Published var errorType: ErrorType?
    
    init(nearestSettlementService: NearestSettlementServiceProtocol) {
        self.nearestSettlementService = nearestSettlementService
    }
    
    func fetchCities() async {
        do {
            cities = try await fetchCities(with: [
                Constants.coordinatesMoscow,
                Constants.coordinatesEkaterinburg
            ])
            
            updateFilteredCities()
        } catch ClientError.noConnection {
            errorType = .noConnection
        } catch {
            errorType = .server
        }
    }
    
    func reset() {
        cities = []
        errorType = nil
        updateFilteredCities()
    }
    
    private func fetchCities(with coordinates: [Coordinate]) async throws -> [City] {
        try await withThrowingTaskGroup(
            of: City.self,
            returning: [City].self
        ) { group in
            coordinates.forEach { coordinate in
                group.addTask {
                    let response = try await self.nearestSettlementService.getNearestSettlement(
                        lat: coordinate.latitude,
                        lng: coordinate.longitude
                    )
                    
                    guard let cityName = response.title else {
                        throw ClientError.server
                    }
                    
                    return .init(name: cityName, coordinate: coordinate)
                }
            }
            
            var cities: [City] = []
            
            for try await result in group {
                cities.append(result)
            }
            
            return cities
        }
    }
    
    private func updateFilteredCities() {
        if searchText.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter { city in
                city.name
                    .lowercased()
                    .contains(searchText.lowercased())
            }
        }
    }
}
