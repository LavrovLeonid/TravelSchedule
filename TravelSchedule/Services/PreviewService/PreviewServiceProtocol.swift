//
//  PreviewServiceProtocol.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 10/20/24.
//

import Foundation

protocol PreviewServiceProtocol: Identifiable {
    var id: UUID { get }
    
    func getPreview() async throws -> [PreviewItem]
}
