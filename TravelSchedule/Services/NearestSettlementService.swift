//
//  NearestSettlementService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation
import OpenAPIRuntime

typealias NearestSettlementResponse = Components.Schemas.NearestSettlementResponse

protocol NearestSettlementServiceProtocol: Sendable {
    func getNearestSettlement(lat: Double, lng: Double) async throws -> NearestSettlementResponse
}

actor NearestSettlementService: BaseServiceProtocol {
    let client: Client
    let apiKey: String?
    
    init(client: Client, apiKey: String? = nil) {
        self.client = client
        self.apiKey = apiKey
    }
}

extension NearestSettlementService: NearestSettlementServiceProtocol {
    func getNearestSettlement(
        lat: Double,
        lng: Double
    ) async throws(ClientError) -> NearestSettlementResponse {
        do {
            let response = try await client.getNearestSettlement(query: .init(
                apikey: apiKey,
                lat: lat,
                lng: lng
            ))
            
            return try response.ok.body.json
        } catch let error as OpenAPIRuntime.ClientError {
            guard case URLError.notConnectedToInternet = error.underlyingError else {
                throw .server
            }
            
            throw .noConnection
        } catch {
            throw .server
        }
    }
}

extension NearestSettlementService: PreviewServiceProtocol {
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
