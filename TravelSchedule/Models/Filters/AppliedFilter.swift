//
//  AppliedFilter.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/22/24.
//

import Foundation

struct AppliedFilter: Equatable, Hashable {
    let filterId: UUID
    let values: Set<AppliedFilterValue>
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(filterId)
    }
    
    static func == (lhs: AppliedFilter, rhs: AppliedFilter) -> Bool {
        lhs.filterId == rhs.filterId
    }
}
