//
//  NavigationBarBackButtonTitleHiddenModifier.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/18/24.
//

import SwiftUI

struct NavigationBarBackButtonTitleHiddenModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss
    
    @ViewBuilder @MainActor func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: { dismiss() }) {
                    Image(.chevronIcon)
                        .renderingMode(.template)
                        .tint(.travelBlack)
                }
            )
            .contentShape(Rectangle())
            .gesture(
                DragGesture(coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.width > .zero,
                           value.translation.height > -30,
                           value.translation.height < 30 {
                            
                            dismiss()
                        }
                    }
            )
    }
}
