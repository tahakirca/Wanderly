import DesignSystem
import Domain
import SwiftUI

@MainActor
final class PlanViewModel: ObservableObject {
    struct RemovedStop: Identifiable {
        let id = UUID()
        let place: Place
        let index: Int
    }

    @Published private(set) var summary = TripSummaryCalculator.summary(for: TripPlan())
    @Published var recentlyRemoved: RemovedStop?

    private let planStore: PlanStore

    init(planStore: PlanStore) {
        self.planStore = planStore
    }

    var stops: [ScheduledStop] {
        summary.stops
    }

    var isEmpty: Bool {
        summary.stops.isEmpty
    }

    func observe() async {
        for await plan in planStore.updates {
            summary = TripSummaryCalculator.summary(for: plan)
        }
    }

    func remove(_ stop: ScheduledStop) {
        recentlyRemoved = RemovedStop(place: stop.place, index: stop.order - 1)
        planStore.remove(stop.place)
        Haptics.medium()
    }

    func move(from source: IndexSet, to destination: Int) {
        planStore.move(from: source, to: destination)
        Haptics.selection()
    }

    func undoRemove() {
        guard let removed = recentlyRemoved else { return }
        planStore.insert(removed.place, at: removed.index)
        recentlyRemoved = nil
    }
}
