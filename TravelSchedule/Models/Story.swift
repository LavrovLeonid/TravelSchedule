//
//  Story.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/22/24.
//

import Foundation

struct Story: Identifiable, Hashable, Equatable {
    let id = UUID()
    let image: ImageResource
    let previewImage: ImageResource
    let title: String
    let description: String
    
    static let story1: Story = .init(
        image: .story1,
        previewImage: .story1Preview,
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    
    static let story2: Story = .init(
        image: .story2,
        previewImage: .story2Preview,
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    
    static let story3: Story = .init(
        image: .story3,
        previewImage: .story3Preview,
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    
    static let story4: Story = .init(
        image: .story4,
        previewImage: .story4Preview,
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
}
