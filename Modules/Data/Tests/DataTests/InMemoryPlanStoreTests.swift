import Domain
import Foundation
import Testing
@testable import Data

@MainActor
@Suite("InMemoryPlanStore")
struct InMemoryPlanStoreTests {
    private func place(_ id: String) -> Place {
        Place(
            id: id,
            name: "Place \(id)",
            category: .landmark,
            rating: 4.0,
            imageURL: URL(string: "https://example.com/\(id).jpg")!,
            estimatedDurationMinutes: 60,
            distanceKm: 1.0,
            description: "",
            openingHours: "",
            priceLevel: .low,
            tags: []
        )
    }

    @Test func addIsIdempotentById() {
        let store = InMemoryPlanStore()
        store.add(place("a"))
        store.add(place("a"))
        #expect(store.plan.places.count == 1)
        #expect(store.contains(place("a")))
    }

    @Test func toggleAddsThenRemoves() {
        let store = InMemoryPlanStore()
        store.toggle(place("a"))
        #expect(store.contains(place("a")))
        store.toggle(place("a"))
        #expect(!store.contains(place("a")))
    }

    @Test func removeDropsThePlace() {
        let store = InMemoryPlanStore()
        store.add(place("a"))
        store.add(place("b"))
        store.remove(place("a"))
        #expect(store.plan.places.map(\.id) == ["b"])
    }

    @Test func moveReorders() {
        let store = InMemoryPlanStore()
        ["a", "b", "c"].forEach { store.add(place($0)) }
        store.move(from: IndexSet(integer: 0), to: 3)
        #expect(store.plan.places.map(\.id) == ["b", "c", "a"])
    }

    @Test func insertRestoresAtIndex() {
        let store = InMemoryPlanStore()
        ["a", "b", "c"].forEach { store.add(place($0)) }
        store.remove(place("b"))
        store.insert(place("b"), at: 1)
        #expect(store.plan.places.map(\.id) == ["a", "b", "c"])
    }

    @Test func insertClampsOutOfRangeIndex() {
        let store = InMemoryPlanStore()
        store.add(place("a"))
        store.insert(place("b"), at: 99)
        #expect(store.plan.places.map(\.id) == ["a", "b"])
    }

    @Test func updatesEmitsCurrentPlanThenEveryChange() async {
        let store = InMemoryPlanStore()
        var stream = store.updates.makeAsyncIterator()

        let current = await stream.next()
        #expect(current?.places.isEmpty == true)

        store.add(place("a"))
        let afterAdd = await stream.next()
        #expect(afterAdd?.places.map(\.id) == ["a"])
    }

    @Test func updatesReachAllSubscribers() async {
        let store = InMemoryPlanStore()
        var first = store.updates.makeAsyncIterator()
        var second = store.updates.makeAsyncIterator()
        _ = await first.next()
        _ = await second.next()

        store.add(place("x"))
        let firstValue = await first.next()
        let secondValue = await second.next()
        #expect(firstValue?.places.map(\.id) == ["x"])
        #expect(secondValue?.places.map(\.id) == ["x"])
    }
}
