//
//  StoryPreviewItem.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/22/24.
//

import SwiftUI

struct StoryPreviewItem: View {
    let isViewed: Bool
    
    var body: some View {
        Image(.story1Preview)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.blue, lineWidth: isViewed ? 0 : 4)
            )
            .opacity(isViewed ? 0.5 : 1)
    }
}

#Preview {
    StoryPreviewItem(
        isViewed: false
    )
}
