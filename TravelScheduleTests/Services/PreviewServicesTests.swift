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
        
        let previewItems = try? await [
            SearchService(client: client).getPreview(),
            ScheduleService(client: client).getPreview(),
            ThreadService(client: client).getPreview(),
            NearestStationsService(client: client).getPreview(),
            NearestSettlementService(client: client).getPreview(),
            CarrierService(client: client).getPreview(),
            StationsListService(client: client).getPreview(),
            CopyrightService(client: client).getPreview()
        ]
        
        #expect(previewItems != nil)
    }
}
