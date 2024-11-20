//
//  CarrierScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/18/24.
//

import SwiftUI

struct CarrierScreenView: View {
    @EnvironmentObject private var carriersViewModel: CarriersViewModel
    
    var body: some View {
        if let selectedCarrier = carriersViewModel.selectedCarrier {
            HStack {
                VStack(alignment: .leading) {
                    Image(.transferFull)
                        .resizable()
                        .padding()
                        .cornerRadius(24)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    Text(selectedCarrier.fullName)
                        .font(.system(size: 24, weight: .bold))
                        .padding(.horizontal)
                        .padding(.bottom)
                    Text("E-mail")
                        .padding(.horizontal)
                    Text(selectedCarrier.email)
                        .foregroundStyle(.travelBlue)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .font(.system(size: 12))
                    Text("Телефон")
                        .padding(.horizontal)
                    Text(selectedCarrier.phone)
                        .foregroundStyle(.travelBlue)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .font(.system(size: 12))
                    Spacer()
                }
                .foregroundStyle(.travelBlack)
            }
            .background(Color.travelWhite)
            .navigationTitle("Информация о перевозчике")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonTitleHidden()
        }
    }
}

#Preview {
    CarrierScreenView()
        .environmentObject(
            CarriersViewModel(selectedCarrier: .init(
                name: "РЖД",
                image: "",
                date: "14 января",
                transfer: "С пересадкой в Костроме",
                startTime: "22:30",
                endTime: "02:15",
                duration: "20 часов",
                fullName: "ОАО «РЖД»",
                fullImage: "",
                email: "i.lozgkina@yandex.ru",
                phone: "+7 (904) 329-27-71"
            ))
        )
}
