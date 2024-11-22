//
//  ChoosingDirectionViewModel.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/15/24.
//

import SwiftUI

final class ChoosingDirectionViewModel: ObservableObject {
    private var direction: Direction = .from
    private var fromCity: City?
    private var fromStation: Station?
    private var toCity: City?
    private var toStation: Station?
    
    @Published var fromText: String = ""
    @Published var toText: String = ""
    
    func setDirection(_ direction: Direction) {
        self.direction = direction
    }
    
    func setCity(_ city: City) {
        switch direction {
            case .from:
                self.fromCity = city
            case .to:
                self.toCity = city
        }
        
        setTexts()
    }
    
    func setStation(_ station: Station) {
        switch direction {
            case .from:
                self.fromStation = station
            case .to:
                self.toStation = station
        }
        
        setTexts()
    }
    
    func rotateDirections() {
        let tempCity = fromCity
        let tempStation = fromStation
        
        fromCity = toCity
        fromStation = toStation
        toCity = tempCity
        toStation = tempStation
        
        setTexts()
    }
    
    private func setTexts() {
        let fromCityText = fromCity?.name ?? ""
        let toCityText = toCity?.name ?? ""
        
        let fromStationText = fromStation.flatMap {
            " (\($0.name))"
        } ?? ""
        
        let toStationText = toStation.flatMap {
            " (\($0.name))"
        } ?? ""
        
        fromText = fromCityText + fromStationText
        toText = toCityText + toStationText
    }
}
