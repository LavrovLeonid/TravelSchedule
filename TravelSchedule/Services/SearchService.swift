//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation

typealias SearchResponse = Components.Schemas.SearchResponse

protocol SearchServiceProtocol {
    func getSearch(from: String, to: String) async throws -> SearchResponse
}

final class SearchService: BaseService, SearchServiceProtocol {
    let id = UUID()
    
    func getSearch(from: String, to: String) async throws -> SearchResponse {
        let response = try await client.getSearch(query: .init(
            apikey: apiKey,
            from: from,
            to: to
        ))
        
        return try response.ok.body.json
    }
}

extension SearchService: PreviewServiceProtocol {
    func getPreview() async -> [PreviewItem] {
        do {
            let searchResponse = try await getSearch(from: "s9813094", to: "s9857049")
            
            return searchResponse.interval_segments?.map {
                PreviewItem(title: $0.thread?.title ?? "")
            } ?? []
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            return []
        }
    }
}
