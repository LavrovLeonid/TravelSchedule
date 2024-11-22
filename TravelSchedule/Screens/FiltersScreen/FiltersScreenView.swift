//
//  FiltersScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/20/24.
//

import SwiftUI

struct FiltersScreenView: View {
    @EnvironmentObject private var navigation: NavigationViewModel
    @EnvironmentObject private var carriersViewModel: CarriersViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(carriersViewModel.filters) { filter in
                        Text(filter.title)
                            .padding()
                            .foregroundStyle(Color.travelBlack)
                            .font(.system(size: 24, weight: .bold))
                        ForEach(filter.options) { option in
                            FilterListItemView(
                                name: option.name,
                                type: filter.type,
                                isChecked: carriersViewModel.isChecked(option: option, for: filter)
                            )
                            .padding()
                            .onTapGesture {
                                carriersViewModel.apply(
                                    option: option,
                                    for: filter
                                )
                            }
                        }
                    }
                }
                Spacer()
            }
            VStack {
                Spacer()
                Button(action: {
                    navigation.pop()
                }) {
                    HStack {
                        Text("Применить")
                            .font(.system(size: 17, weight: .bold))
                        if !carriersViewModel.appliedFilters.isEmpty {
                            Ellipse()
                                .fill(.redUniversal)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 40)
                }
                .buttonStyle(.borderedProminent)
                .tint(.travelBlue)
                .cornerRadius(16)
                .padding(.bottom)
                .padding(.horizontal)
            }
        }
        .background(Color.travelWhite)
        .navigationBarBackButtonTitleHidden()
    }
}

#Preview {
    FiltersScreenView()
}
