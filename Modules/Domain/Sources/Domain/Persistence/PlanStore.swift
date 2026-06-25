import Foundation

@MainActor
public protocol PlanStore: AnyObject {
    var plan: TripPlan { get }
    var updates: AsyncStream<TripPlan> { get }

    func contains(_ place: Place) -> Bool
    func toggle(_ place: Place)
    func add(_ place: Place)
    func remove(_ place: Place)
    func insert(_ place: Place, at index: Int)
    func move(from source: IndexSet, to destination: Int)
    func setStartTime(minutes: Int)
}
