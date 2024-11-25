//
//  StoriesTabView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/23/24.
//

import SwiftUI

struct StoriesTabView: View {
    let stories: [Story]
    @Binding var currentStoryIndex: Int
    
    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(Array(stories.enumerated()), id: \.element) { index, story in
                StoryItemView(story: story)
                    .onTapGesture {
                        didTapStory()
                    }
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    func didTapStory() {
        currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
    }
}

#Preview {
    StoriesTabView(stories: [.story1, .story2], currentStoryIndex: .init(get: {
        0
    }, set: { _ in
        
    }))
}
