import Data
import DesignSystem
import ExploreFeature
import PlanFeature
import SwiftUI

struct RootTabView: View {
    let container: AppContainer
    @EnvironmentObject private var theme: ThemeController
    @ObservedObject private var planStore: InMemoryPlanStore
    @State private var selection = Tab.explore

    private enum Tab {
        case explore
        case plan
    }

    init(container: AppContainer) {
        self.container = container
        _planStore = ObservedObject(wrappedValue: container.planStore)
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
