import Foundation

enum CountdownRepository {
    static let appGroupIdentifier = "group.com.careylzh.daystoliberation"
    private static let storageKey = "countdowns"

    static func load(defaults: UserDefaults = sharedDefaults) -> [Countdown] {
        guard let data = defaults.data(forKey: storageKey),
              let countdowns = try? JSONDecoder().decode([Countdown].self, from: data) else {
            return [.sample]
        }
        return countdowns.sorted { $0.date < $1.date }
    }

    static func save(_ countdowns: [Countdown], defaults: UserDefaults = sharedDefaults) throws {
        let data = try JSONEncoder().encode(countdowns)
        defaults.set(data, forKey: storageKey)
    }

    private static var sharedDefaults: UserDefaults {
        UserDefaults(suiteName: appGroupIdentifier) ?? .standard
    }
}

