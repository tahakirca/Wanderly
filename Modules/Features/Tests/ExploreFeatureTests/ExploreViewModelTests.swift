import Domain
import Foundation
import Testing
@testable import ExploreFeature

@MainActor
@Suite("ExploreViewModel")
struct ExploreViewModelTests {
    @Test func filtersByCategoryThenSearch() async {
        let viewModel = ExploreViewModel(fetchPlaces: StubFetchPlaces(places: samplePlaces), planStore: StubPlanStore())
        await viewModel.load()

        #expect(viewModel.visiblePlaces.count == 3)

        viewModel.selectedCategory = .cafe
        #expect(viewModel.visiblePlaces.map(\.id) == ["c1"])

        viewModel.selectedCategory = nil
        viewModel.searchText = "fort"
        #expect(viewModel.visiblePlaces.map(\.id) == ["l1"])
    }

    @Test func searchAlsoMatchesTags() async {
        let viewModel = ExploreViewModel(fetchPlaces: StubFetchPlaces(places: samplePlaces), planStore: StubPlanStore())
        await viewModel.load()

        viewModel.searchText = "coffee"
        #expect(viewModel.visiblePlaces.map(\.id) == ["c1"])
    }

    private var samplePlaces: [Place] {
        [
            place(id: "l1", name: "Amber Fort", category: .landmark, tags: ["historic"]),
            place(id: "c1", name: "Brew Lane", category: .cafe, tags: ["coffee"]),
            place(id: "r1", name: "Spice Kitchen", category: .restaurant, tags: ["dinner"])
        ]
    }

    private func place(id: String, name: String, category: PlaceCategory, tags: [String]) -> Place {
        Place(
            id: id,
            name: name,
            category: category,
            rating: 4.5,
            imageURL: URL(string: "https://picsum.photos/seed/\(id)/400/300")!,
            estimatedDurationMinutes: 60,
            distanceKm: 2,
            description: "A nice spot.",
            openingHours: "9:00 AM - 6:00 PM",
            priceLevel: .medium,
            tags: tags
        )
    }
}

private struct StubFetchPlaces: FetchPlacesUseCase {
    let places: [Place]

    func execute() async throws -> [Place] {
        places
    }
}

@MainActor
private final class StubPlanStore: PlanStore {
    private(set) var plan = TripPlan()

    var updates: AsyncStream<TripPlan> {
        AsyncStream { $0.finish() }
    }

    func toggle(_ place: Place) {}
    func remove(_ place: Place) {}
    func insert(_ place: Place, at index: Int) {}
    func move(from source: IndexSet, to destination: Int) {}
}
