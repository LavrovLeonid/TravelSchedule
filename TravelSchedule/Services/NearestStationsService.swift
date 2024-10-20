//
//  NearestStationsService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation

typealias NearestStationsResponse = Components.Schemas.NearestStationsResponse

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStationsResponse
}

final class NearestStationsService: BaseService, NearestStationsServiceProtocol {
    let id = UUID()
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStationsResponse {
        let response = try await client.getNearestStations(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        
        return try response.ok.body.json
    }
}

extension NearestStationsService: PreviewServiceProtocol {
    func getPreview() async -> [PreviewItem] {
        do {
            let nearestStationsResponse = try await getNearestStations(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50
            )
            
            return nearestStationsResponse.stations?.map { station in
                PreviewItem(title: station.title ?? "")
            } ?? []
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            return []
        }
    }
}
