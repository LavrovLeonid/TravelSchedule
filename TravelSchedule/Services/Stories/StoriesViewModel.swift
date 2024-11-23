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
    
    func viewStory(_ story: Story) {
        viewedStories.insert(story.id)
    }
}
