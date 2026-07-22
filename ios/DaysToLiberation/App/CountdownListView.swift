import SwiftUI

struct CountdownListView: View {
    @EnvironmentObject private var store: CountdownStore
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            Group {
                if store.countdowns.isEmpty {
                    ContentUnavailableView(
                        "No Countdowns",
                        systemImage: "calendar.badge.plus",
                        description: Text("Add a date, then pin its widget to your Home Screen.")
                    )
                } else {
                    List {
                        ForEach(store.countdowns) { countdown in
                            NavigationLink(value: countdown) {
                                CountdownRow(countdown: countdown)
                            }
                        }
                        .onDelete(perform: store.delete)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Countdowns")
            .navigationDestination(for: Countdown.self) { countdown in
                CountdownDetailView(countdown: countdown)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add countdown", systemImage: "plus") {
                        showingAddSheet = true
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                CountdownEditorView()
            }
            .alert("Unable to Save", isPresented: Binding(
                get: { store.errorMessage != nil },
                set: { if !$0 { store.errorMessage = nil } }
            )) {
                Button("OK", role: .cancel) { store.errorMessage = nil }
            } message: {
                Text(store.errorMessage ?? "Unknown error")
            }
        }
    }
}

private struct CountdownRow: View {
    let countdown: Countdown

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 5) {
                Text(countdown.name)
                    .font(.headline)
                Text(countdown.date, format: .dateTime.day().month(.wide).year())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(spacing: 1) {
                Text("\(abs(countdown.daysRemaining()))")
                    .font(.title2.bold())
                    .monospacedDigit()
                Text(countdown.status())
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

