//
//  NearestSettlementService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation

typealias NearestSettlementResponse = Components.Schemas.NearestSettlementResponse

protocol NearestSettlementServiceProtocol {
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlementResponse
}

final class NearestSettlementService: BaseService, NearestSettlementServiceProtocol {
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlementResponse {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng
        ))
        
        return try response.ok.body.json
    }
}

extension NearestSettlementService: PreviewServiceProtocol {
    var id: UUID {
        UUID()
    }
    
    func getPreview() async throws -> [PreviewItem] {
        do {
            let nearestSettlementResponse = try await getNearestSettlement(
                lat: 59.864177,
                lng: 30.319163
            )
            
            return [PreviewItem(title: nearestSettlementResponse.title ?? "")]
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            throw error
        }
    }
}
