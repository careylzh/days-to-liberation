import SwiftUI
import WidgetKit

struct CountdownEntry: TimelineEntry {
    let date: Date
    let countdown: Countdown
}

struct CountdownProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> CountdownEntry {
        CountdownEntry(date: Date(), countdown: .sample)
    }

    func snapshot(for configuration: SelectCountdownIntent, in context: Context) async -> CountdownEntry {
        CountdownEntry(date: Date(), countdown: selectedCountdown(for: configuration))
    }

    func timeline(for configuration: SelectCountdownIntent, in context: Context) async -> Timeline<CountdownEntry> {
        let now = Date()
        let entry = CountdownEntry(date: now, countdown: selectedCountdown(for: configuration))
        let nextMidnight = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: now))
            ?? now.addingTimeInterval(3600)
        return Timeline(entries: [entry], policy: .after(nextMidnight))
    }

    private func selectedCountdown(for configuration: SelectCountdownIntent) -> Countdown {
        let countdowns = CountdownRepository.load()
        guard let selectedID = configuration.countdown?.id else {
            return countdowns.first ?? .sample
        }
        return countdowns.first(where: { $0.id == selectedID }) ?? countdowns.first ?? .sample
    }
}

struct CountdownWidgetView: View {
    @Environment(\.widgetFamily) private var family
    let entry: CountdownEntry

    var body: some View {
        VStack(alignment: .leading, spacing: family == .systemSmall ? 7 : 10) {
            Text(entry.countdown.name)
                .font(family == .systemSmall ? .headline : .title3.bold())
                .lineLimit(2)

            Spacer(minLength: 0)

            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text("\(abs(entry.countdown.daysRemaining(from: entry.date)))")
                    .font(.system(size: family == .systemSmall ? 48 : 58, weight: .heavy, design: .rounded))
                    .monospacedDigit()
                    .minimumScaleFactor(0.65)
                if family != .systemSmall {
                    Text(entry.countdown.status(from: entry.date).uppercased())
                        .font(.caption.bold())
                        .foregroundStyle(.secondary)
                }
            }

            if family == .systemSmall {
                Text(entry.countdown.status(from: entry.date).uppercased())
                    .font(.caption2.bold())
                    .foregroundStyle(.secondary)
            } else {
                Text(entry.countdown.date, format: .dateTime.day().month(.wide).year())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .containerBackground(for: .widget) {
            LinearGradient(
                colors: [.indigo.opacity(0.72), .teal.opacity(0.55)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}

struct CountdownWidget: Widget {
    let kind = "CountdownWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectCountdownIntent.self, provider: CountdownProvider()) { entry in
            CountdownWidgetView(entry: entry)
        }
        .configurationDisplayName("Days to Liberation")
        .description("Pin one of your countdowns to the Home Screen.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

@main
struct DaysToLiberationWidgetBundle: WidgetBundle {
    var body: some Widget {
        CountdownWidget()
    }
}

