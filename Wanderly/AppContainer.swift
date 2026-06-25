import Data
import DesignSystem
import Domain
import ExploreFeature
import PlanFeature
import SwiftUI

@MainActor
final class AppContainer: ObservableObject {
    let theme = ThemeController()
    let planStore = InMemoryPlanStore()

    private let fetchPlaces: FetchPlacesUseCase

    init() {
        fetchPlaces = FetchPlacesUseCaseImpl(repository: LocalPlacesRepository())
    }

    func makeExplore() -> some View {
        ExploreFactory.make(fetchPlaces: fetchPlaces, planStore: planStore)
    }

    func makePlan(onBrowse: @escaping () -> Void) -> some View {
        PlanFactory.make(planStore: planStore, onBrowse: onBrowse)
    }
}
