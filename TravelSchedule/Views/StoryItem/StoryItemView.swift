//
//  StoryItemView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/23/24.
//

import SwiftUI

struct StoryItemView: View {
    let story: Story
    
    var body: some View {
        Image(story.image)
            .resizable()
            .cornerRadius(40)
            .aspectRatio(contentMode: .fill)
            .overlay(
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        Text(story.title)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(3)
                            .foregroundColor(.white)
                        Text(story.description)
                            .font(.system(size: 20))
                            .lineLimit(3)
                            .foregroundColor(.white)
                            .padding(.top)
                    }
                    .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
                }
            )
    }
}

#Preview {
    StoryItemView(story: .story1)
}
