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
        
        let client = Client(
            serverURL: serverURL,
            transport: URLSessionTransport()
        )
        
        return [
            SearchService(client: client, apiKey: Constants.apiKey),
            ScheduleService(client: client, apiKey: Constants.apiKey),
            ThreadService(client: client, apiKey: Constants.apiKey),
            NearestStationsService(client: client, apiKey: Constants.apiKey),
            NearestSettlementService(client: client, apiKey: Constants.apiKey),
            CarrierService(client: client, apiKey: Constants.apiKey),
            StationsListService(client: client, apiKey: Constants.apiKey),
            CopyrightService(client: client, apiKey: Constants.apiKey)
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
    
    func fetchPreview(service: any PreviewServiceProtocol) {
        isLoadingPreview = true
        
        Task {
            previewItems = await service.getPreview()
            isLoadingPreview = false
        }
    }
}

#Preview {
    ContentView()
}
