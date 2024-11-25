//
//  StoriesScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/23/24.
//

import SwiftUI

struct StoriesScreenView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var storiesViewModel: StoriesViewModel
    
    @State private var currentProgress = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.blackUniversal.edgesIgnoringSafeArea(.all)
            if #available(iOS 17.0, *) {
                StoriesTabView(
                    stories: storiesViewModel.stories,
                    currentStoryIndex: $storiesViewModel.currentStoryIndex
                )
                .onChange(of: storiesViewModel.currentStoryIndex) { oldValue, newValue in
                    didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
                }
                StoriesProgressBar(
                    storiesCount: storiesViewModel.stories.count,
                    timerConfiguration: storiesViewModel.timerConfiguration,
                    currentProgress: $storiesViewModel.currentProgress
                )
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 0))
                .onChange(of: storiesViewModel.currentProgress) { _, newValue in
                    didChangeCurrentProgress(newProgress: newValue)
                }
            }
            Button(action: {
                dismiss()
            }) {
                Image(.closeIcon)
                    .frame(width: 30, height: 30)
            }
            .padding(.top, 50)
            .padding(.trailing, 12)
        }
    }
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = storiesViewModel.timerConfiguration.progress(for: newIndex)
        
        guard abs(progress - storiesViewModel.currentProgress) >= 0.01 else { return }
        
        withAnimation {
            storiesViewModel.currentProgress = progress
        }
    }
    
    private func didChangeCurrentProgress(newProgress: CGFloat) {
        let index = storiesViewModel.timerConfiguration.index(for: newProgress)
        
        guard index != storiesViewModel.currentStoryIndex else { return }
        
        withAnimation {
            storiesViewModel.currentStoryIndex = index
        }
    }
}

#Preview {
    StoriesScreenView()
        .environmentObject(StoriesViewModel())
}
