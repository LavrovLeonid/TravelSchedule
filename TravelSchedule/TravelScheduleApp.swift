//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/16/24.
//

import SwiftUI
import SDWebImage
import SDWebImageSVGKitPlugin

@main
struct TravelScheduleApp: App {
    init() {
        SDImageCodersManager.shared.addCoder(SDImageSVGKCoder.shared)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
