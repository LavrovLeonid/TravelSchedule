//
//  View+navigationBarBackButtonTitleHidden.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/18/24.
//

import SwiftUI

extension View {
    func navigationBarBackButtonTitleHidden() -> some View {
        modifier(NavigationBarBackButtonTitleHiddenModifier())
    }
}
