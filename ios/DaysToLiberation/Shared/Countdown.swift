import Foundation

struct Countdown: Codable, Hashable, Identifiable, Sendable {
    var id: UUID
    var name: String
    var date: Date

    init(id: UUID = UUID(), name: String, date: Date) {
        self.id = id
        self.name = name
        self.date = date
    }

    func daysRemaining(from now: Date = Date(), calendar: Calendar = .current) -> Int {
        let today = calendar.startOfDay(for: now)
        let target = calendar.startOfDay(for: date)
        return calendar.dateComponents([.day], from: today, to: target).day ?? 0
    }

    func status(from now: Date = Date(), calendar: Calendar = .current) -> String {
        let days = daysRemaining(from: now, calendar: calendar)
        if days == 0 { return "happening today" }
        return days < 0 ? "days since" : "days to go"
    }
}

extension Countdown {
    static let sample = Countdown(
        id: UUID(uuidString: "A07E3C98-349D-4B89-91DA-3F3CE6E59B5A")!,
        name: "Copa De Singapura - Grand Finale",
        date: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2026, month: 11, day: 14))!
    )
}

