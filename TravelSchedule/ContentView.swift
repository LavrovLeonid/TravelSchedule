//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/16/24.
//

import SwiftUI
import OpenAPIURLSession

struct ResultItem {
    let title: String
}

struct ContentView: View {
    private var previewServices: [any PreviewServiceProtocol] {
        guard let serverURL = try? Servers.server1() else { return [] }
        
        let authenticationMiddleware = AuthenticationMiddleware(
            apiKey: Constants.apiKey
        )
        
        let client = Client(
            serverURL: serverURL,
            transport: URLSessionTransport(),
            middlewares: [authenticationMiddleware]
        )
        
        return [
            SearchService(client: client),
            ScheduleService(client: client),
            ThreadService(client: client),
            NearestStationsService(client: client),
            NearestSettlementService(client: client),
            CarrierService(client: client),
            StationsListService(client: client),
            CopyrightService(client: client)
        ]
    }
    
    @State private var isLoadingPreview: Bool = false
    @State private var previewItems: [PreviewItem] = []
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(previewServices, id: \.id) { service in
                        Button(String(describing: service)) {
                            fetchPreview(service: service)
                        }
                    }
                }
                List {
                    ForEach(previewItems, id: \.id) { item in
                        Text(item.title)
                    }
                }
            }.disabled(isLoadingPreview)
            isLoadingPreview ? ProgressView() : nil
        }
    }
    
    func fetchPreview(service: some PreviewServiceProtocol) {
        isLoadingPreview = true
        
        Task {
            previewItems = (try? await service.getPreview()) ?? []
            isLoadingPreview = false
        }
    }
}

#Preview {
    ContentView()
}
