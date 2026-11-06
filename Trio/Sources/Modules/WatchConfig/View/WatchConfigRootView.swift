import SwiftUI
import Swinject

extension WatchConfig {
    struct RootView: BaseView {
        let resolver: Resolver
        @StateObject var state = StateModel()

        @Environment(\.colorScheme) var colorScheme
        @Environment(AppState.self) var appState
        @State private var smartwatchSheet: SmartwatchSheet?
        @State private var smartwatchRevision = 0

        var body: some View {
            List {
                Section(
                    header: Text("Smartwatch Configuration"),
                    content: {
                        NavigationLink("Apple Watch", destination: WatchConfigAppleWatchView(resolver: resolver, state: state))
                        // Rebuilt when a watch is added or removed.
                        WatchConfigSmartwatchRows(resolver: resolver, sheet: $smartwatchSheet)
                            .id(smartwatchRevision)
                    }
                ).listRowBackground(Color.chart)
            }
            .smartwatchSheets(resolver: resolver, sheet: $smartwatchSheet, revision: $smartwatchRevision)
            .scrollContentBackground(.hidden).background(appState.trioBackgroundColor(for: colorScheme))
            .onAppear(perform: configureView)
            .navigationTitle("Watch")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
