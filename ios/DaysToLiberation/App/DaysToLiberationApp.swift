import SwiftUI

@main
struct DaysToLiberationApp: App {
    @StateObject private var store = CountdownStore()

    var body: some Scene {
        WindowGroup {
            CountdownListView()
                .environmentObject(store)
        }
    }
}

