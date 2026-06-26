import Data
import DesignSystem
import ExploreFeature
import PlanFeature
import SwiftUI

struct RootTabView: View {
    let container: AppContainer
    @Environment(ThemeController.self) private var theme
    @State private var selection = Tab.explore

    private enum Tab {
        case explore
        case plan
    }

    init(container: AppContainer) {
        self.container = container
    }

    private var planStore: InMemoryPlanStore {
        container.planStore
    }

    var body: some View {
        TabView(selection: $selection) {
            NavigationStack {
                container.makeExplore()
            }
            .toolbarBackground(.visible, for: .tabBar)
            .tabItem {
                Label("Explore", systemImage: "map")
            }
            .tag(Tab.explore)

            NavigationStack {
                container.makePlan(onBrowse: { selection = .explore })
            }
            .toolbarBackground(.visible, for: .tabBar)
            .tabItem {
                Label("My Plan", systemImage: "list.bullet")
            }
            .badge(planCount)
            .tag(Tab.plan)
        }
        .tint(WanderlyColor.teal)
        .preferredColorScheme(theme.colorScheme)
    }

    private var planCount: Text? {
        let count = planStore.plan.places.count
        return count > 0 ? Text("\(count)") : nil
    }
}
