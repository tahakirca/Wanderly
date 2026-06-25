import Domain
import SwiftUI

@MainActor
final class ExploreViewModel: ObservableObject {
    @Published private(set) var places: [Place] = []
    @Published private(set) var isLoading = true
    @Published var searchText = ""
    @Published var selectedCategory: PlaceCategory?
    @Published private(set) var planIDs: Set<String> = []

    private let fetchPlaces: FetchPlacesUseCase
    private let planStore: PlanStore

    init(fetchPlaces: FetchPlacesUseCase, planStore: PlanStore) {
        self.fetchPlaces = fetchPlaces
        self.planStore = planStore
    }

    var visiblePlaces: [Place] {
        places.filter { place in
            matchesCategory(place) && matchesSearch(place)
        }
    }

    var planCount: Int {
        planIDs.count
    }

    func isInPlan(_ place: Place) -> Bool {
        planIDs.contains(place.id)
    }

    func load() async {
        isLoading = true
        // The data is local, so hold the skeleton briefly to keep that state visible.
        try? await Task.sleep(for: .seconds(0.6))
        places = (try? await fetchPlaces.execute()) ?? []
        isLoading = false
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
