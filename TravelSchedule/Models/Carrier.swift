//
//  Carrier.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/17/24.
//

import Foundation

struct Carrier: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let date: String
    let transfer: String?
    let startTime: String
    let endTime: String
    let duration: String
    let fullName: String
    let fullImage: String
    let email: String
    let phone: String
}
