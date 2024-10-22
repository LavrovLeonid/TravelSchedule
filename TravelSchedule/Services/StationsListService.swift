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
    func getStationsList() async throws -> StationsListResponse {
        let response = try await client.getStationsList(query: .init(
            apikey: apiKey,
            format: .json
        ))
        
        let html = try response.ok.body.html
        
        return try await JSONDecoder().decode(from: html, to: StationsListResponse.self)
    }
}

extension StationsListService: PreviewServiceProtocol {
    var id: UUID {
        UUID()
    }
    
    func getPreview() async throws -> [PreviewItem] {
        do {
            let stationsListResponse = try await getStationsList()
            
            return stationsListResponse.countries?.map {
                PreviewItem(title: $0.title ?? "")
            } ?? []
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            throw error
        }
    }
}
