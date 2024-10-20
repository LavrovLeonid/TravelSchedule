//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation

typealias StationsListResponse = Components.Schemas.StationsListResponse

protocol StationsListServiceProtocol {
    func getStationsList() async throws -> StationsListResponse
}

final class StationsListService: BaseService, StationsListServiceProtocol {
    let id = UUID()
    
    func getStationsList() async throws -> StationsListResponse {
        let response = try await client.getStationsList(query: .init(
            apikey: apiKey,
            format: .json
        ))
        
        return try response.ok.body.json
    }
}

extension StationsListService: PreviewServiceProtocol {
    func getPreview() async -> [PreviewItem] {
        do {
            let stationsListResponse = try await getStationsList()
            
            return stationsListResponse.countries?.map {
                PreviewItem(title: $0.title ?? "")
            } ?? []
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            return []
        }
    }
}
