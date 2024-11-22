//
//  FilterListItemView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/20/24.
//

import SwiftUI

struct FilterListItemView: View {
    let name: String
    let type: FilterType
    let isChecked: Bool
    
    var body: some View {
        HStack {
            Text(name)
                .foregroundStyle(.travelBlack)
            Spacer()
            if type == .checkbox {
                Image(isChecked ? .checkboxOnIcon : .checkboxOffIcon)
                    .renderingMode(.template)
                    .tint(Color.travelBlack)
            } else if type == .radio {
                Image(isChecked ? .radioOnIcon : .radioOffIcon)
                    .renderingMode(.template)
                    .tint(Color.travelBlack)
            }
        }
        .background(Color.travelWhite)
    }
}

#Preview {
    FilterListItemView(
        name: "Утро 06:00 - 12:00",
        type: .radio,
        isChecked: false
    )
}
