import Foundation
import WidgetKit

@MainActor
final class CountdownStore: ObservableObject {
    @Published private(set) var countdowns: [Countdown]
    @Published var errorMessage: String?

    init() {
        countdowns = CountdownRepository.load()
    }

    func add(name: String, date: Date) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }
        countdowns.append(Countdown(name: trimmedName, date: date))
        persist()
    }

    func update(_ countdown: Countdown, name: String, date: Date) {
        guard let index = countdowns.firstIndex(where: { $0.id == countdown.id }) else { return }
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }
        countdowns[index].name = trimmedName
        countdowns[index].date = date
        persist()
    }

    func delete(at offsets: IndexSet) {
        countdowns.remove(atOffsets: offsets)
        persist()
    }

    private func persist() {
        countdowns.sort { $0.date < $1.date }
        do {
            try CountdownRepository.save(countdowns)
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            errorMessage = "Your changes could not be saved. \(error.localizedDescription)"
        }
    }
}

