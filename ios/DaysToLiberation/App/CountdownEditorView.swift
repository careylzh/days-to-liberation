import SwiftUI

struct CountdownEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: CountdownStore

    let countdown: Countdown?
    @State private var name: String
    @State private var date: Date

    init(countdown: Countdown? = nil) {
        self.countdown = countdown
        _name = State(initialValue: countdown?.name ?? "")
        _date = State(initialValue: countdown?.date ?? Calendar.current.startOfDay(for: Date()))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Event") {
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.words)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }

                Section {
                    Text("Widgets refresh automatically after changes and at the next calendar day.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(countdown == nil ? "New Countdown" : "Edit Countdown")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let countdown {
                            store.update(countdown, name: name, date: date)
                        } else {
                            store.add(name: name, date: date)
                        }
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

