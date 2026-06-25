import SwiftUI

@main
struct WanderlyApp: App {
    @StateObject private var container = AppContainer()

    var body: some Scene {
        WindowGroup {
            RootTabView(container: container)
                .environmentObject(container.theme)
        }
    }
}
