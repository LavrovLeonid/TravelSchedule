//
//  CarriersScreenViewModel.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/17/24.
//

import SwiftUI

struct FilterOption: Identifiable {
    let id = UUID()
    let name: String
}

enum FilterType {
    case checkbox
    case radio
}

struct Filter: Identifiable {
    let id = UUID()
    let title: String
    let type: FilterType
    let options: [FilterOption]
}

struct AppliedFilter: Equatable, Hashable {
    let filterId: UUID
    let values: Set<AppliedFilterValues>
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(filterId)
    }
    
    static func == (lhs: AppliedFilter, rhs: AppliedFilter) -> Bool {
        lhs.filterId == rhs.filterId
    }
}

enum AppliedFilterValues: Hashable {
    case checkbox(Set<UUID>)
    case radio(UUID)
}

final class CarriersViewModel: ObservableObject {
    @Published var carriers: [Carrier] = [
        .init(
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
        ),
        .init(
            name: "РЖД",
            image: "",
            date: "14 января",
            transfer: nil,
            startTime: "22:30",
            endTime: "02:15",
            duration: "20 часов",
            fullName: "ОАО «РЖД»",
            fullImage: "",
            email: "i.lozgkina@yandex.ru",
            phone: "+7 (904) 329-27-71"
        ),
        .init(
            name: "РЖД",
            image: "",
            date: "14 января",
            transfer: nil,
            startTime: "22:30",
            endTime: "02:15",
            duration: "20 часов",
            fullName: "ОАО «РЖД»",
            fullImage: "",
            email: "i.lozgkina@yandex.ru",
            phone: "+7 (904) 329-27-71"
        ),
        .init(
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
        ),
        .init(
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
        ),
        .init(
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
    ]
    @Published var selectedCarrier: Carrier?
    @Published var filters: [Filter] = [
        .init(
            title: "Время отправления",
            type: .checkbox,
            options: [
                .init(name: "Утро 06:00 - 12:00"),
                .init(name: "День 12:00 - 18:00"),
                .init(name: "Вечер 18:00 - 00:00"),
                .init(name: "Ночь 00:00 - 06:00")
            ]),
        .init(
            title: "Показывать варианты с пересадками",
            type: .radio,
            options: [
                .init(name: "Да"),
                .init(name: "Нет")
            ]
        )
    ]
    @Published var appliedFilters = Dictionary<UUID, AppliedFilterValues>()
    
    init(selectedCarrier: Carrier? = nil) {
        self.selectedCarrier = selectedCarrier
    }
    
    func setSelectedCarrier(_ carrier: Carrier) {
        selectedCarrier = carrier
    }
    
    func isChecked(option: FilterOption, for filter: Filter) -> Bool {
        guard let appliedFilterValues = appliedFilters[filter.id] else { return false }
        
        switch filter.type {
            case .checkbox:
                guard case .checkbox(let uuids) = appliedFilterValues else { fallthrough }
                
                return uuids.contains(option.id)
            case .radio:
                guard case .radio(let uuid) = appliedFilterValues else { fallthrough }
                
                return uuid == option.id
            default:
                return false
        }
    }
    
    func apply(option: FilterOption, for filter: Filter) {
        if let appliedFilterValues = appliedFilters[filter.id] {
            switch filter.type {
                case .checkbox:
                    guard case .checkbox(let uuids) = appliedFilterValues else { return }
                    
                    if uuids.contains(option.id) {
                        let newUuids = uuids.subtracting([option.id])
                        
                        if newUuids.isEmpty {
                            appliedFilters.removeValue(forKey: filter.id)
                        } else {
                            appliedFilters.updateValue(.checkbox(uuids.subtracting([option.id])), forKey: filter.id)
                        }
                    } else {
                        appliedFilters.updateValue(.checkbox(uuids.union([option.id])), forKey: filter.id)
                    }
                case .radio:
                    appliedFilters.updateValue(.radio(option.id), forKey: filter.id)
            }
        } else {
            switch filter.type {
                case .checkbox:
                    appliedFilters.updateValue(
                        .checkbox([option.id]),
                        forKey: filter.id
                    )
                case .radio:
                    appliedFilters.updateValue(
                        .radio(option.id),
                        forKey: filter.id
                    )
            }
        }
    }
}
