//
//  UserAgreementScreenView.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/28/24.
//

import SwiftUI

struct UserAgreementScreenView: View {
    var body: some View {
        WebView(url: Constants.agreementUrl)
            .navigationTitle("Пользовательское соглашение")
            .background(Color.travelWhite)
    }
}

#Preview {
    UserAgreementScreenView()
}
