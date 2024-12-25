//
//  City.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/15/24.
//

import Foundation

struct City: Identifiable, DestinationProtocol {
    let id = UUID()
    let name: String
    let coordinate: Coordinate
}
