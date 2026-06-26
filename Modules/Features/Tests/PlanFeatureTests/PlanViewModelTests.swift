import Domain
import Foundation
import SwiftUI
import Testing
@testable import PlanFeature

@MainActor
@Suite("PlanViewModel")
struct PlanViewModelTests {
    @Test func undoReinsertsTheStopAtItsOriginalIndex() {
        let store = StubPlanStore(places: [place("a"), place("b"), place("c")])
        let viewModel = PlanViewModel(planStore: store)

        viewModel.remove(stop(place("b"), order: 2))
        #expect(store.plan.places.map(\.id) == ["a", "c"])

        viewModel.undoRemove()
        #expect(store.plan.places.map(\.id) == ["a", "b", "c"])
    }

    @Test func reorderClearsThePendingUndo() {
        let store = StubPlanStore(places: [place("a"), place("b"), place("c")])
        let viewModel = PlanViewModel(planStore: store)

        viewModel.remove(stop(place("a"), order: 1))
        #expect(viewModel.recentlyRemoved != nil)

        viewModel.move(from: IndexSet(integer: 0), to: 2)
        #expect(viewModel.recentlyRemoved == nil)
    }

    private func stop(_ place: Place, order: Int) -> ScheduledStop {
        ScheduledStop(place: place, order: order, arrivalMinutes: 0, travelMinutesBefore: 0)
    }

    private func place(_ id: String) -> Place {
        Place(
            id: id,
            name: "Place \(id)",
            category: .landmark,
            rating: 4.0,
            imageURL: URL(string: "https://example.com/\(id).jpg")!,
            estimatedDurationMinutes: 60,
            distanceKm: 1,
            description: "",
            openingHours: "",
            priceLevel: .low,
            tags: []
        )
    }
}

@MainActor
private final class StubPlanStore: PlanStore {
    private(set) var plan: TripPlan

    init(places: [Place]) {
        plan = TripPlan(places: places)
    }

    var updates: AsyncStream<TripPlan> {
        AsyncStream { $0.finish() }
    }

    func toggle(_ place: Place) {}

    func remove(_ place: Place) {
        plan.places.removeAll { $0.id == place.id }
    }

    func insert(_ place: Place, at index: Int) {
        plan.places.insert(place, at: min(max(0, index), plan.places.count))
    }

    func move(from source: IndexSet, to destination: Int) {
        plan.places.move(fromOffsets: source, toOffset: destination)
    }
}
