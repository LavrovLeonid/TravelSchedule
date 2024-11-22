//
//  ListItem.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/11/24.
//

import SwiftUI

struct ListItem: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(.arrowForwardIcon)
                .renderingMode(.template)
                .tint(Color.travelBlack)
        }
        .padding()
    }
}

#Preview {
    ListItem(title: "List item title")
}
