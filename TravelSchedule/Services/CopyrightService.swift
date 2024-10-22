//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation

typealias CopyrightResponse = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightResponse
}

final class CopyrightService: BaseService, CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightResponse {
        let response = try await client.getCopyright(query: .init(
            apikey: apiKey,
            format: .json
        ))
        
        return try response.ok.body.json
    }
}

extension CopyrightService: PreviewServiceProtocol {
    var id: UUID {
        UUID()
    }
    
    func getPreview() async throws -> [PreviewItem] {
        do {
            let copyrightResponse = try await getCopyright()
            
            return [PreviewItem(title: copyrightResponse.copyright?.text ?? "")]
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            throw error
        }
    }
}
