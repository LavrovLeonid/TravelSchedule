//
//  NearestStationsService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation

typealias NearestStationsResponse = Components.Schemas.NearestStationsResponse

protocol NearestStationsServiceProtocol: Sendable {
    func getNearestStations(
        lat: Double,
        lng: Double,
        distance: Int,
        limit: Components.Parameters.limit?
    ) async throws -> NearestStationsResponse
}

actor NearestStationsService: BaseServiceProtocol {
    let client: Client
    let apiKey: String?
    
    init(client: Client, apiKey: String? = nil) {
        self.client = client
        self.apiKey = apiKey
    }
}

extension NearestStationsService: NearestStationsServiceProtocol {
    func getNearestStations(
        lat: Double,
        lng: Double,
        distance: Int,
        limit: Components.Parameters.limit?
    ) async throws -> NearestStationsResponse {
        let response = try await client.getNearestStations(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng,
            distance: distance,
            limit: limit
        ))
        
        return try response.ok.body.json
    }
}

extension NearestStationsService: PreviewServiceProtocol {
    func getPreview() async throws -> [PreviewItem] {
        do {
            let nearestStationsResponse = try await getNearestStations(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50,
                limit: nil
            )
            
            return nearestStationsResponse.stations?.map { station in
                PreviewItem(title: station.title ?? "")
            } ?? []
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            throw error
        }
    }
}
