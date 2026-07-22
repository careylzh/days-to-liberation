import SwiftUI

struct CountdownDetailView: View {
    @EnvironmentObject private var store: CountdownStore
    let countdown: Countdown
    @State private var showingEditSheet = false

    private var currentCountdown: Countdown {
        store.countdowns.first(where: { $0.id == countdown.id }) ?? countdown
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.indigo.opacity(0.95), Color.teal.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 22) {
                Text(currentCountdown.name)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)

                Text(currentCountdown.date, format: .dateTime.day().month(.wide).year())
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.mint)

                GlassEffectContainer(spacing: 20) {
                    VStack(spacing: 10) {
                        Text("\(abs(currentCountdown.daysRemaining()))")
                            .font(.system(size: 100, weight: .heavy, design: .rounded))
                            .monospacedDigit()
                        Text(currentCountdown.status().uppercased())
                            .font(.headline)
                            .tracking(1.5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 30)
                    .glassEffect(.regular.tint(.indigo.opacity(0.2)), in: .rect(cornerRadius: 24))
                }

                Text("Add a Days to Liberation widget from the Home Screen, then long-press it and choose this countdown.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.75))
            }
            .padding(24)
            .foregroundStyle(.white)
        }
        .navigationTitle("Countdown")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Edit", systemImage: "pencil") { showingEditSheet = true }
                .buttonStyle(.glass)
        }
        .sheet(isPresented: $showingEditSheet) {
            CountdownEditorView(countdown: currentCountdown)
        }
    }
}
