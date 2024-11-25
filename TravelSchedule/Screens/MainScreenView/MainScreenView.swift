//
//  MainScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/27/24.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject private var navigation: NavigationViewModel
    @EnvironmentObject private var choosingDirectionViewModel: ChoosingDirectionViewModel
    @EnvironmentObject private var storiesViewModel: StoriesViewModel
    
    @State private var isPresentStories = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(storiesViewModel.stories) { story in
                        StoryPreviewItem(story: story, isViewed: storiesViewModel.viewedStories.contains(story.id))
                            .frame(width: 92, height: 140)
                            .onTapGesture {
                                storiesViewModel.storyPreviewTapped(story)
                                isPresentStories.toggle()
                            }
                    }
                }
            }
            .padding(
                .init(top: 24, leading: 16, bottom: 24, trailing: 16)
            )
            ChoosingDirectionView(
                fromText: $choosingDirectionViewModel.fromText,
                toText: $choosingDirectionViewModel.toText,
                onTapFrom: {
                    choosingDirectionViewModel.setDirection(.from)
                    navigation.push(screen: .cities)
                },
                onTapTo: {
                    choosingDirectionViewModel.setDirection(.to)
                    navigation.push(screen: .cities)
                }
            ) {
                choosingDirectionViewModel.rotateDirections()
            }
            .padding()
            if !choosingDirectionViewModel.fromText.isEmpty,
               !choosingDirectionViewModel.toText.isEmpty {
                Button(action: {
                    navigation.push(screen: .carriers)
                }) {
                    Text("Найти")
                        .frame(width: 150, height: 60)
                        .font(.system(size: 17, weight: .bold))
                }
                .buttonStyle(.borderedProminent)
                .tint(.travelBlue)
                .cornerRadius(16)
            }
            Spacer()
        }
        .background(Color.travelWhite)
        .fullScreenCover(isPresented: $isPresentStories) {
            StoriesScreenView()
        }
    }
}

#Preview {
    MainScreenView()
        .environmentObject(NavigationViewModel())
        .environmentObject(ChoosingDirectionViewModel())
        .environmentObject(StoriesViewModel())
}
