//
//  PreviewServicesTests.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/22/24.
//

import Testing
import OpenAPIURLSession
@testable import TravelSchedule

struct PreviewServicesTests {
    @Test func previewServicesTests() async throws {
        let authenticationMiddleware = AuthenticationMiddleware(
            apiKey: Constants.apiKey
        )
        
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [authenticationMiddleware]
        )
        
        await #expect(throws: Never.self ) {
            let response = try await SearchService(client: client).getPreview()
            
            #expect(response != nil)
        }
        
        await #expect(throws: Never.self ) {
            let response = try await ScheduleService(client: client).getPreview()
            
            #expect(response != nil)
        }
        
        await #expect(throws: Never.self ) {
            let response = try await ThreadService(client: client).getPreview()
            
            #expect(response != nil)
        }
        
        await #expect(throws: Never.self ) {
            let response = try await NearestStationsService(client: client).getPreview()
            
            #expect(response != nil)
        }
        
        await #expect(throws: Never.self ) {
            let response = try await NearestSettlementService(client: client).getPreview()
            
            #expect(response != nil)
        }
        
        await #expect(throws: Never.self ) {
            let response = try await CarrierService(client: client).getPreview()
            
            #expect(response != nil)
        }
        
        await #expect(throws: Never.self ) {
            let response = try await StationsListService(client: client).getPreview()
            
            #expect(response != nil)
        }
        
        await #expect(throws: Never.self ) {
            let response = try await CopyrightService(client: client).getPreview()
            
            #expect(response != nil)
        }
    }
}
