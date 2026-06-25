import ExploreFeature
import PlanFeature
import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ExploreFactory.make()
            }
            .tabItem {
                Label("Explore", systemImage: "map")
            }

            NavigationStack {
                PlanFactory.make()
            }
            .tabItem {
                Label("My Plan", systemImage: "list.bullet")
            }
        }
    }
}
