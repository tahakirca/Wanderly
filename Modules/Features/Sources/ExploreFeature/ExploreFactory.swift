import Domain
import SwiftUI

public enum ExploreFactory {
    @MainActor
    public static func make(fetchPlaces: FetchPlacesUseCase, planStore: PlanStore) -> some View {
        ExploreView(viewModel: ExploreViewModel(fetchPlaces: fetchPlaces, planStore: planStore))
    }
}
