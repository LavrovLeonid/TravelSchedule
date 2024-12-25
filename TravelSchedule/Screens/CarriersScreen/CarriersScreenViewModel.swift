//
//  CarriersScreenViewModel.swift
//  TravelSchedule
//
//  Created by Леонид Лавров on 11/17/24.
//

import Foundation

enum FilterKeys: Hashable {
    case time
    case transfer
}

@MainActor
final class CarriersViewModel: ObservableObject {
    private let searchService: SearchServiceProtocol
    
    private let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        
        return dateFormatter
    }()
    private let parseDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }()
    private let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    private let iso8601DateFormatter: ISO8601DateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        
        return dateFormatter
    }()
    
    private var carriers: [Carrier] = []
    
    @Published var filteredCarriers: [Carrier] = []
    @Published var selectedCarrier: Carrier?
    @Published var errorType: ErrorType?
    @Published var filters: [AnyFilter] = []
    @Published var hasTransfers: Bool? = nil
    @Published var timeIntervals: [Date] = []
    
    private let calendar = Calendar.current
    
    init(searchService: SearchServiceProtocol) {
        self.searchService = searchService
        setupFilters()
    }
    
    func setSelectedCarrier(_ carrier: Carrier) {
        selectedCarrier = carrier
    }
    
    func isChecked(option: AnyFilterOption, for filter: AnyFilter) -> Bool {
        switch filter.key as? FilterKeys {
            case .time:
                guard let optionDate = option.value as? Date else { return false }
                return timeIntervals.contains(optionDate)
            case .transfer:
                guard let optionTransfer = option.value as? Bool else { return false }
                return hasTransfers == optionTransfer
            default:
                return false
        }
    }
    
    func apply(option: AnyFilterOption, for filter: AnyFilter) {
        switch filter.key as? FilterKeys {
            case .time:
                guard let optionDate = option.value as? Date else { return }
                if timeIntervals.contains(optionDate) {
                    timeIntervals.removeAll { $0 == optionDate }
                } else {
                    timeIntervals.append(optionDate)
                }
            case .transfer:
                guard let optionTransfer = option.value as? Bool else { return }
                hasTransfers = optionTransfer
            default:
                break
        }
        
        updateCarriers()
    }
    
    func reset() {
        selectedCarrier = nil
        carriers = []
        errorType = nil
        timeIntervals = []
        hasTransfers = nil
    }
    
    private func setupFilters() {
        let today = Date()
        
        filters = [
            .init(
                key: FilterKeys.time,
                title: "Время отправления",
                type: .checkbox,
                options: [
                    .init(
                        name: "Утро 06:00 - 12:00",
                        value: calendar.date(bySettingHour: 6, minute: 0, second: 0, of: today)!
                    ),
                    .init(
                        name: "День 12:00 - 18:00",
                        value: calendar.date(bySettingHour: 12, minute: 0, second: 0, of: today)!
                    ),
                    .init(
                        name: "Вечер 18:00 - 00:00",
                        value: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: today)!
                    ),
                    .init(
                        name: "Ночь 00:00 - 06:00",
                        value: calendar.date(bySettingHour: 0, minute: 0, second: 0, of: today)!
                    )
                ]),
            .init(
                key: FilterKeys.transfer,
                title: "Показывать варианты с пересадками",
                type: .radio,
                options: [
                    .init(name: "Да", value: true),
                    .init(name: "Нет", value: false)
                ]
            )
        ]
    }
    
    private func formatTime(from date: Date?) -> String? {
        guard let date else { return nil }
        
        return timeFormatter.string(from: date)
    }

    private func formatDuration(from seconds: Double) -> String {
        let hours = Int(seconds) / 3600
        let hourString: String
        switch hours % 10 {
        case 1:
            hourString = (hours % 100 == 11) ? "часов" : "час"
        case 2, 3, 4:
            hourString = (hours % 100 >= 12 && hours % 100 <= 14) ? "часов" : "часа"
        default:
            hourString = "часов"
        }
        return "\(hours) \(hourString)"
    }
    
    func fetchCarriers(from: String, to: String) async {
        do {
            let response = try await searchService.getSearch(
                from: from,
                to: to,
                date: Date(),
                transfers: true
            )
            
            carriers = response.segments?.compactMap { segment in
                guard
                    let carrier = segment.thread?.carrier,
                    let startDate = segment.start_date,
                    let date = parseDateFormatter.date(from: startDate),
                    let departure = segment.departure,
                    let arrival = segment.arrival,
                    let duration = segment.duration
                else { return nil }
                
                let name = carrier.title ?? ""
                
                let departureDate = iso8601DateFormatter.date(from: departure)
                let arrivalDate = iso8601DateFormatter.date(from: arrival)
                
                let formattedDeparture = formatTime(from: departureDate) ?? ""
                let formattedArrival = formatTime(from: arrivalDate) ?? ""
                let formattedDuration = formatDuration(from: duration)

                return Carrier(
                    name: name,
                    image: carrier.logo_svg ?? carrier.logo ?? "",
                    date: displayDateFormatter.string(from: date),
                    transfer: segment.stops,
                    startDate: departureDate,
                    endDate: arrivalDate,
                    startTime: formattedDeparture,
                    endTime: formattedArrival,
                    duration: formattedDuration,
                    fullName: name,
                    fullImage: carrier.logo ?? "",
                    email: carrier.email ?? "",
                    phone: carrier.phone ?? ""
                )
            } ?? []
            
            updateCarriers()
        } catch ClientError.noConnection {
            errorType = .noConnection
        } catch {
            errorType = .server
        }
    }
    
    private func updateCarriers() {
        if timeIntervals.isEmpty && hasTransfers == nil {
            filteredCarriers = carriers
        } else {
            filteredCarriers = carriers.filter { filterCarrier($0) }
        }
    }
    
    private func filterCarrier(_ carrier: Carrier) -> Bool {
        if let hasTransfers,
           let transfer = carrier.transfer,
           (transfer.isEmpty && !hasTransfers || !transfer.isEmpty && hasTransfers) {
            return true
        }
        
        guard let startDate = carrier.startDate else { return false }
        
        let startTimeInterval = calendar.component(.hour, from: startDate) * 3600 +
                                calendar.component(.minute, from: startDate) * 60
        
        for filterStartDate in timeIntervals {
            let filterStartInterval =
                calendar.component(.hour, from: filterStartDate) * 3600 +
                calendar.component(.minute, from: filterStartDate) * 60
            let filterEndInterval = filterStartInterval + 6 * 3600

            if startTimeInterval >= filterStartInterval &&
               startTimeInterval < filterEndInterval {
                return true
            }
        }
        
        return false
    }
}
