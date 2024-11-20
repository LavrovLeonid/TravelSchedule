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
    
    var body: some View {
        VStack {
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
    }
}

#Preview {
    MainScreenView()
}
