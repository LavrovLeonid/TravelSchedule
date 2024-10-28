//
//  UserAgreementScreen.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/28/24.
//

import SwiftUI

struct UserAgreementScreen: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            WebView(url: Constants.agreementUrl)
                .navigationTitle("Пользовательское соглашение")
                .toolbar(.hidden, for: .tabBar)
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    UserAgreementScreen()
}
