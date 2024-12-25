//
//  FilterOption.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/22/24.
//

import Foundation

typealias AnyFilterOption = FilterOption<Any>

struct FilterOption<T>: Identifiable {
    let id = UUID()
    let name: String
    let value: T
}
