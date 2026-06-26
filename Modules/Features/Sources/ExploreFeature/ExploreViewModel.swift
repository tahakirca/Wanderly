import Domain
import SwiftUI

@Observable
@MainActor
final class ExploreViewModel {
    private(set) var places: [Place] = []
    private(set) var isLoading = true
    var searchText = ""
    var selectedCategory: PlaceCategory?
    private(set) var planIDs: Set<String> = []

    @ObservationIgnored private let fetchPlaces: FetchPlacesUseCase
    @ObservationIgnored private let planStore: PlanStore
    @ObservationIgnored private var hasLoaded = false

    init(fetchPlaces: FetchPlacesUseCase, planStore: PlanStore) {
        self.fetchPlaces = fetchPlaces
        self.planStore = planStore
    }

    var visiblePlaces: [Place] {
        places.filter { place in
            matchesCategory(place) && matchesSearch(place)
        }
    }

    func isInPlan(_ place: Place) -> Bool {
        planIDs.contains(place.id)
    }

    func load() async {
        guard !hasLoaded else { return }
        isLoading = true
        // The data is local, so hold the skeleton briefly to keep that state visible.
        try? await Task.sleep(for: .seconds(0.6))
        let loaded = (try? await fetchPlaces.execute()) ?? []
        guard !Task.isCancelled else { return }
        places = loaded
        isLoading = false
        hasLoaded = true
    }

    func observePlan() async {
        for await plan in planStore.updates {
            planIDs = Set(plan.places.map(\.id))
        }
    }

    func togglePlan(_ place: Place) {
        planStore.toggle(place)
    }

    private func matchesCategory(_ place: Place) -> Bool {
        selectedCategory == nil || place.category == selectedCategory
    }

    private func matchesSearch(_ place: Place) -> Bool {
        let query = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        guard !query.isEmpty else { return true }
        return place.name.lowercased().contains(query)
            || place.description.lowercased().contains(query)
            || place.tags.contains { $0.lowercased().contains(query) }
    }
}
