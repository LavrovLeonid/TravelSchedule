//
//  NavigationViewModel.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/6/24.
//

import Foundation

final class NavigationViewModel: ObservableObject {
    @Published var path: [NavigationScreen] = []
    
    func popToRoot() {
        path = []
    }
    
    func push(screen: NavigationScreen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
}
