import XCTest
@testable import DaysToLiberation

final class CountdownTests: XCTestCase {
    private var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Singapore")!
        return calendar
    }

    func testFutureCountdownUsesCalendarDays() throws {
        let now = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 7, day: 22, hour: 23)))
        let target = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 7, day: 25)))
        let countdown = Countdown(name: "Future", date: target)

        XCTAssertEqual(countdown.daysRemaining(from: now, calendar: calendar), 3)
        XCTAssertEqual(countdown.status(from: now, calendar: calendar), "days to go")
    }

    func testTodayAndPastStatuses() throws {
        let now = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 7, day: 22, hour: 12)))
        let today = Countdown(name: "Today", date: now)
        let pastDate = try XCTUnwrap(calendar.date(from: DateComponents(year: 2026, month: 7, day: 20)))
        let past = Countdown(name: "Past", date: pastDate)

        XCTAssertEqual(today.daysRemaining(from: now, calendar: calendar), 0)
        XCTAssertEqual(today.status(from: now, calendar: calendar), "happening today")
        XCTAssertEqual(past.daysRemaining(from: now, calendar: calendar), -2)
        XCTAssertEqual(past.status(from: now, calendar: calendar), "days since")
    }

    func testRepositoryRoundTrip() throws {
        let suiteName = "CountdownTests.\(UUID().uuidString)"
        let defaults = try XCTUnwrap(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }
        let values = [Countdown(name: "One", date: Date(timeIntervalSince1970: 1_800_000_000))]

        try CountdownRepository.save(values, defaults: defaults)

        XCTAssertEqual(CountdownRepository.load(defaults: defaults), values)
    }
}

