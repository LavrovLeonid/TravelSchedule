//
//  StoryPreviewItem.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/22/24.
//

import SwiftUI

struct StoryPreviewItem: View {
    let story: Story
    let isViewed: Bool
    
    var body: some View {
        Image(story.previewImage)
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
        story: .story1,
        isViewed: false
    )
}
