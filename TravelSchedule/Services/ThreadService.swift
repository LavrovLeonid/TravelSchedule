//
//  ThreadService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/17/24.
//

import Foundation

typealias ThreadResponse = Components.Schemas.ThreadResponse

protocol ThreadServiceProtocol {
    func getThread(uid: String) async throws -> ThreadResponse
}

final class ThreadService: BaseService, ThreadServiceProtocol {
    func getThread(uid: String) async throws -> ThreadResponse {
        let response = try await client.getThread(query: .init(
            apikey: apiKey,
            uid: uid
        ))
        
        return try response.ok.body.json
    }
}

extension ThreadService: PreviewServiceProtocol {
    var id: UUID {
        UUID()
    }
    
    func getPreview() async throws -> [PreviewItem] {
        do {
            let threadResponse = try await getThread(
                uid: "empty_1_f9813109t9878648_175"
            )
            
            return [PreviewItem(title: threadResponse.title ?? "")]
        } catch {
            print("Fetch preview error in SearchService: \(error)")
            
            throw error
        }
    }
}
