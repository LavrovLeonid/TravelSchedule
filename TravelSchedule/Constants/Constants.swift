//
//  Constants.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/20/24.
//

import Foundation

enum Constants {
    static let apiKey = "4816cc87-e8d0-492a-acb6-000b7a2b6c49"
    static let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    static let agreementUrl = URL(string: "https://yandex.ru/legal/practicum_offer")!
    
    static let coordinatesMoscow = Coordinate(latitude: 55.75, longitude: 37.62)
    static let coordinatesEkaterinburg = Coordinate(latitude: 56.83, longitude: 60.58)
    
    static let nearestDistanceLimit: Int = 10
}
