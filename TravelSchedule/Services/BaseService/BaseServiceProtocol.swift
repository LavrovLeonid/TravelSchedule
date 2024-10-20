//
//  BaseServiceProtocol.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/20/24.
//

protocol BaseServiceProtocol {
    var client: Client { get }
    var apiKey: String { get }
}
