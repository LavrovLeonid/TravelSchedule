//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/22/24.
//

import Combine
import Foundation

final class StoriesViewModel: ObservableObject {
    @Published var stories: [Story] = [.story1, .story2, .story3, .story4]
    @Published var viewedStories = Set<UUID>()
    @Published var currentStoryIndex: Int = 0 {
        didSet {
            guard let story = stories[safe: currentStoryIndex] else { return }
            
            viewedStories.insert(story.id)
        }
    }
    @Published var currentProgress: CGFloat = 0
    
    var timerConfiguration: TimerConfiguration {
        .init(storiesCount: stories.count)
    }
    
    func storyPreviewTapped(_ story: Story) {
        guard let index = stories.firstIndex(of: story) else { return }
        
        currentStoryIndex = index
        currentProgress = timerConfiguration.progress(for: index)
    }
}
