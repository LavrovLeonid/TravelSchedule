//
//  CarrierScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/18/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CarrierScreenView: View {
    @EnvironmentObject private var carriersViewModel: CarriersViewModel
    
    var body: some View {
        if let selectedCarrier = carriersViewModel.selectedCarrier {
            HStack {
                VStack(alignment: .leading) {
                    WebImage(url: URL(string: selectedCarrier.image)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.travelLightGray
                    }
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
}
