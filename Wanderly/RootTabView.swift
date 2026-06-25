import Data
import DesignSystem
import ExploreFeature
import PlanFeature
import SwiftUI

struct RootTabView: View {
    let container: AppContainer
    @EnvironmentObject private var theme: ThemeController
    @ObservedObject private var planStore: InMemoryPlanStore

    init(container: AppContainer) {
        self.container = container
        _planStore = ObservedObject(wrappedValue: container.planStore)
    }

    var body: some View {
        TabView {
            NavigationStack {
                container.makeExplore()
            }
            .tabItem {
                Label("Explore", systemImage: "map")
            }

            NavigationStack {
                container.makePlan()
            }
            .tabItem {
                Label("My Plan", systemImage: "list.bullet")
            }
            .badge(planCount)
        }
        .tint(WanderlyColor.teal)
        .preferredColorScheme(theme.colorScheme)
    }

    private var planCount: Text? {
        let count = planStore.plan.places.count
        return count > 0 ? Text("\(count)") : nil
    }
}
