import SwiftUI

@main
struct WanderlyApp: App {
    @State private var container = AppContainer()

    var body: some Scene {
        WindowGroup {
            RootTabView(container: container)
                .environment(container.theme)
        }
    }
}
