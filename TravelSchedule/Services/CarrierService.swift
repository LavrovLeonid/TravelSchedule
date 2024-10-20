//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation

typealias CarrierResponse = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarrier(code: String) async throws -> CarrierResponse
}

final class CarrierService: BaseService, CarrierServiceProtocol {
    let id = UUID()
    
    func getCarrier(code: String) async throws -> CarrierResponse {
        let response = try await client.getCarrier(query: .init(
            apikey: apiKey,
            code: code
        ))
        
        return try response.ok.body.json
    }
}

extension CarrierService: PreviewServiceProtocol {
    func getPreview() async -> [PreviewItem] {
        do {
            let carrierResponse = try await getCarrier(code: "680")
            
            return [PreviewItem(title: carrierResponse.carrier?.title ?? "")]
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            return []
        }
    }
}
