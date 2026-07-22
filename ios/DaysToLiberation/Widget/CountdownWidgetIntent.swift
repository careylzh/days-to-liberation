import AppIntents
import WidgetKit

struct CountdownEntity: AppEntity {
    static let typeDisplayRepresentation = TypeDisplayRepresentation(name: "Countdown")
    static let defaultQuery = CountdownEntityQuery()

    let id: UUID
    let name: String
    let date: Date

    init(_ countdown: Countdown) {
        id = countdown.id
        name = countdown.name
        date = countdown.date
    }

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(name)",
            subtitle: "\(date.formatted(date: .abbreviated, time: .omitted))"
        )
    }
}

struct CountdownEntityQuery: EntityQuery {
    func entities(for identifiers: [UUID]) async throws -> [CountdownEntity] {
        CountdownRepository.load()
            .filter { identifiers.contains($0.id) }
            .map(CountdownEntity.init)
    }

    func suggestedEntities() async throws -> [CountdownEntity] {
        CountdownRepository.load().map(CountdownEntity.init)
    }

    func defaultResult() async -> CountdownEntity? {
        CountdownRepository.load().first.map(CountdownEntity.init)
    }
}

struct SelectCountdownIntent: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Choose Countdown"
    static let description = IntentDescription("Select the event this widget should track.")

    @Parameter(title: "Countdown")
    var countdown: CountdownEntity?
}

