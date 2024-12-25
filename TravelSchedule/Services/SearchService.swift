//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation

typealias SearchResponse = Components.Schemas.SearchResponse

protocol SearchServiceProtocol: Sendable {
    func getSearch(from: String, to: String, date: Date, transfers: Bool) async throws -> SearchResponse
}

actor SearchService: BaseServiceProtocol {
    let client: Client
    let apiKey: String?
    
    init(client: Client, apiKey: String? = nil) {
        self.client = client
        self.apiKey = apiKey
    }
}

extension SearchService: SearchServiceProtocol {
    func getSearch(from: String, to: String, date: Date, transfers: Bool) async throws -> SearchResponse {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let response = try await client.getSearch(query: .init(
            apikey: apiKey,
            from: from,
            to: to,
            date: dateFormatter.string(from: date),
            transfers: transfers
        ))
        
        return try response.ok.body.json
    }
}

extension SearchService: PreviewServiceProtocol {
    func getPreview() async throws -> [PreviewItem] {
        do {
            let searchResponse = try await getSearch(
                from: "s9813094", to: "s9857049", date: Date(), transfers: true
            )
            
            return searchResponse.segments?.map {
                PreviewItem(title: $0.thread?.title ?? "")
            } ?? []
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            throw error
        }
    }
}
