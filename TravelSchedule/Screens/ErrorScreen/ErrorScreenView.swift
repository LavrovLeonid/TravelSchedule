//
//  ErrorScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/20/24.
//

import SwiftUI

struct ErrorScreenView: View {
    let errorType: ErrorType
    
    var body: some View {
        VStack {
            Image(errorType.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 223, height: 223)
            Text(errorType.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.travelBlack)
        }
        .background(Color.travelWhite)
    }
}

#Preview {
    ErrorScreenView(errorType: .noConnection)
}
