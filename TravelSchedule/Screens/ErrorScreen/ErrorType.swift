//
//  ErrorType.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/20/24.
//

import SwiftUI

enum ErrorType {
    case server
    case noConnection
    
    var image: ImageResource {
        switch self {
            case .server:
                .serverError
            case .noConnection:
                .noConnectionError
        }
    }
    
    var title: String {
        switch self {
            case .server:
                "Ошибка сервера"
            case .noConnection:
                "Нет интернета"
        }
    }
}
