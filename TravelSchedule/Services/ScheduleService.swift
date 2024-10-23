//
//  ScheduleService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func getSchedule(station: String) async throws -> ScheduleResponse
}

final class ScheduleService: BaseService, ScheduleServiceProtocol {
    func getSchedule(station: String) async throws -> ScheduleResponse {
        let response = try await client.getSchedule(query: .init(
            apikey: apiKey,
            station: station
        ))
        
        return try response.ok.body.json
    }
}

extension ScheduleService: PreviewServiceProtocol {
    func getPreview() async throws -> [PreviewItem] {
        do {
            let scheduleResponse = try await getSchedule(
                station: "s9813094"
            )
            
            return [PreviewItem(title: scheduleResponse.station?.title ?? "")]
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            throw error
        }
    }
}
