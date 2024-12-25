//
//  Station.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/15/24.
//

import Foundation

struct Station: DestinationProtocol {
    let code: String
    let name: String
    let coordinate: Coordinate
}

extension Station: Identifiable {
    var id: String { code }
}
