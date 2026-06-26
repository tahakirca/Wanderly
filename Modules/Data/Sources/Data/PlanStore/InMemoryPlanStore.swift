import Domain
import Foundation
import SwiftUI

@Observable
@MainActor
public final class InMemoryPlanStore: PlanStore {
    public private(set) var plan: TripPlan

    @ObservationIgnored private var continuations: [UUID: AsyncStream<TripPlan>.Continuation] = [:]

    public init(plan: TripPlan = TripPlan()) {
        self.plan = plan
    }

    public var updates: AsyncStream<TripPlan> {
        AsyncStream { continuation in
            let id = UUID()
            continuations[id] = continuation
            continuation.yield(plan)
            continuation.onTermination = { [weak self] _ in
                Task { @MainActor in self?.continuations[id] = nil }
            }
        }
    }

    public func contains(_ place: Place) -> Bool {
        plan.contains(place)
    }

    public func toggle(_ place: Place) {
        if contains(place) {
            remove(place)
        } else {
            add(place)
        }
    }

    public func add(_ place: Place) {
        guard !contains(place) else { return }
        plan.places.append(place)
        broadcast()
    }

    public func remove(_ place: Place) {
        plan.places.removeAll { $0.id == place.id }
        broadcast()
    }

    public func insert(_ place: Place, at index: Int) {
        let safeIndex = max(0, min(index, plan.places.count))
        plan.places.insert(place, at: safeIndex)
        broadcast()
    }

    public func move(from source: IndexSet, to destination: Int) {
        plan.places.move(fromOffsets: source, toOffset: destination)
        broadcast()
    }

    public func setStartTime(minutes: Int) {
        plan.startMinutes = minutes
        broadcast()
    }

    private func broadcast() {
        for continuation in continuations.values {
            continuation.yield(plan)
        }
    }
}
