//
//  CarrierListItemView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/17/24.
//

import SwiftUI

struct CarrierListItemView: View {
    let carrier: Carrier
    
    var body: some View {
        VStack(spacing: 18) {
            HStack(spacing: 8) {
                Image(.transfer)
                    .resizable()
                    .cornerRadius(12)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 38, height: 38)
                VStack(alignment: .leading) {
                    HStack {
                        Text(carrier.name)
                        Spacer()
                        Text(carrier.date)
                            .font(.system(size: 12))
                    }
                    if let transfer = carrier.transfer {
                        Text(transfer)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.redUniversal)
                    }
                }
            }
            HStack {
                Text(carrier.startTime)
                VStack {
                    Divider()
                        .background(Color.grayUniversal)
                }
                Text(carrier.duration)
                    .font(.system(size: 12))
                VStack {
                    Divider()
                        .background(Color.grayUniversal)
                }
                Text(carrier.endTime)
            }
        }
        .foregroundStyle(Color.blackUniversal)
        .padding(14)
        .background(Color.travelLightGray)
        .cornerRadius(24)
    }
}

#Preview {
    CarrierListItemView(
        carrier: .init(
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
        )
    )
}
