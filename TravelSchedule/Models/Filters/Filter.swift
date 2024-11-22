//
//  Filter.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/22/24.
//

import Foundation

struct Filter: Identifiable {
    let id = UUID()
    let title: String
    let type: FilterType
    let options: [FilterOption]
}
