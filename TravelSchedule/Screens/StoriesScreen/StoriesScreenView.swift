//
//  StoriesScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/23/24.
//

import SwiftUI

struct StoriesScreenView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            Button("Dismiss Modal") {
                dismiss()
            }
        }
    }
}

#Preview {
    StoriesScreenView()
}
