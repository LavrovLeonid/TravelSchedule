//
//  Filter.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/22/24.
//

import Foundation

typealias AnyFilter = Filter<Any, AnyHashable>

struct Filter<T, K: Hashable>: Identifiable {
    let id = UUID()
    let key: K
    let title: String
    let type: FilterType
    let options: [FilterOption<T>]
}
