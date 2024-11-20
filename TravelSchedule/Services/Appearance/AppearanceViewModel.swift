//
//  AppearanceViewModel.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/20/24.
//

import SwiftUI

final class AppearanceViewModel: ObservableObject {
    @Published var colorScheme: ColorScheme = .light
    @Published var isDarkMode: Bool = false {
        didSet {
            toggleColorScheme()
        }
    }
    
    func toggleColorScheme() {
        colorScheme = colorScheme == .light ? .dark : .light
    }
}
