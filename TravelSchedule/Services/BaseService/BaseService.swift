//
//  BaseService.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/20/24.
//

class BaseService: BaseServiceProtocol {
    let client: Client
    let apiKey: String?
    
    init(client: Client, apiKey: String? = nil) {
        self.client = client
        self.apiKey = apiKey
    }
}
