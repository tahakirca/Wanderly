public enum TripSummaryCalculator {
    public static func summary(for plan: TripPlan) -> TripSummary {
        var stops: [ScheduledStop] = []
        var clock = plan.startMinutes
        var previous: Place?

        for (index, place) in plan.places.enumerated() {
            let travel = previous.map { travelMinutes(from: $0, to: place) } ?? 0
            clock += travel
            stops.append(
                ScheduledStop(
                    place: place,
                    order: index + 1,
                    arrivalMinutes: clock,
                    travelMinutesBefore: travel
                )
            )
            clock += place.estimatedDurationMinutes
            previous = place
        }

        let totalCost = plan.places.reduce(0) { $0 + $1.priceLevel.estimatedCostUSD }

        return TripSummary(
            stops: stops,
            startMinutes: plan.startMinutes,
            endMinutes: clock,
            totalCostUSD: totalCost,
            categoryBreakdown: breakdown(of: plan.places)
        )
    }

    // Closer stops are quicker to reach; clamped to a sensible 8–45 min range.
    static func travelMinutes(from origin: Place, to destination: Place) -> Int {
        let estimate = 8 + abs(origin.distanceKm - destination.distanceKm) * 2.2
        return min(45, max(8, Int(estimate.rounded())))
    }

    private static func breakdown(of places: [Place]) -> [CategoryCount] {
        PlaceCategory.allCases.compactMap { category in
            let count = places.filter { $0.category == category }.count
            return count > 0 ? CategoryCount(category: category, count: count) : nil
        }
    }
}
