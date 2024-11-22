//
//  AppliedFIlterValue.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/22/24.
//

import Foundation

enum AppliedFilterValue: Hashable {
    case checkbox(Set<UUID>)
    case radio(UUID)
}
