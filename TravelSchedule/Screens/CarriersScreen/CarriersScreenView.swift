//
//  CarriersScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/17/24.
//

import SwiftUI

struct CarriersScreenView: View {
    @EnvironmentObject private var navigation: NavigationViewModel
    @EnvironmentObject private var choosingDirectionViewModel: ChoosingDirectionViewModel
    @EnvironmentObject private var carriersViewModel: CarriersViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("\(choosingDirectionViewModel.fromText) → \(choosingDirectionViewModel.toText)"
                )
                .padding()
                .font(.system(size: 24, weight: .bold))
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(Color.travelBlack)
                if carriersViewModel.filteredCarriers.isEmpty {
                    Spacer()
                    Text("Вариантов нет")
                        .foregroundStyle(.travelBlack)
                        .font(.system(size: 24, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(carriersViewModel.filteredCarriers) { carrier in
                                CarrierListItemView(carrier: carrier)
                                    .onTapGesture {
                                        carriersViewModel.setSelectedCarrier(carrier)
                                        navigation.push(screen: .carrier)
                                    }
                            }
                        }
                        .padding(.init(top: 0, leading: 16, bottom: 70, trailing: 16))
                        Spacer()
                    }
                }
            }
            VStack {
                switch carriersViewModel.errorType {
                    case .some(let errorType):
                        ErrorScreenView(errorType: errorType)
                    case .none:
                        Spacer()
                        Button(action: {
                            navigation.push(screen: .filters)
                        }) {
                            HStack {
                                Text("Уточнить время")
                                    .font(.system(size: 17, weight: .bold))
                                if carriersViewModel.hasTransfers != nil ||
                                    !carriersViewModel.timeIntervals.isEmpty {
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
        }
        .background(Color.travelWhite)
        .navigationBarBackButtonTitleHidden()
        .task {
            guard
                let fromStation = choosingDirectionViewModel.fromStation,
                let toStation = choosingDirectionViewModel.toStation
            else { return }
            
            await carriersViewModel.fetchCarriers(from: fromStation.code, to: toStation.code)
        }
    }
}

#Preview {
    CarriersScreenView()
        .environmentObject(ChoosingDirectionViewModel())
}
