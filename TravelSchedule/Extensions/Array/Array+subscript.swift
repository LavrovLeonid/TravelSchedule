//
//  Array+subscript.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/24/24.
//

extension Array {
    subscript(safe index: Index) -> Element? {
        indices ~= index ? self[index] : nil
    }
}
