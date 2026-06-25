import Foundation
import Testing
@testable import Domain

@Suite("Trip summary")
struct TripSummaryCalculatorTests {
    @Test("Empty plan has no stops and ends where it starts")
    func emptyPlan() {
        let summary = TripSummaryCalculator.summary(for: TripPlan())

        #expect(summary.stops.isEmpty)
        #expect(summary.endMinutes == summary.startMinutes)
        #expect(summary.totalDurationMinutes == 0)
        #expect(summary.totalCostUSD == 0)
        #expect(summary.exceedsDayLimit == false)
    }

    @Test("First stop is reached at the start time with no travel before it")
    func firstStopStartsAtNine() {
        let plan = TripPlan(places: [place(duration: 90)])
        let summary = TripSummaryCalculator.summary(for: plan)

        #expect(summary.stops.first?.arrivalMinutes == 9 * 60)
        #expect(summary.stops.first?.travelMinutesBefore == 0)
        #expect(summary.endMinutes == 9 * 60 + 90)
    }

    @Test("Second stop arrives after the first visit plus travel time")
    func scheduleChainsAcrossStops() {
        let first = place(duration: 60, distanceKm: 2)
        let second = place(duration: 45, distanceKm: 10)
        let summary = TripSummaryCalculator.summary(for: TripPlan(places: [first, second]))

        let travel = TripSummaryCalculator.travelMinutes(from: first, to: second)
        #expect(summary.stops[1].travelMinutesBefore == travel)
        #expect(summary.stops[1].arrivalMinutes == 9 * 60 + 60 + travel)
        #expect(summary.endMinutes == 9 * 60 + 60 + travel + 45)
    }

    @Test("Travel time stays within the 8–45 minute range")
    func travelTimeIsClamped() {
        let near = place(distanceKm: 5)
        let alsoNear = place(distanceKm: 5)
        let faraway = place(distanceKm: 80)

        #expect(TripSummaryCalculator.travelMinutes(from: near, to: alsoNear) == 8)
        #expect(TripSummaryCalculator.travelMinutes(from: near, to: faraway) == 45)
    }

    @Test("A day longer than ten hours is flagged")
    func longDayTriggersWarning() {
        let marathon = TripPlan(places: [place(duration: 300), place(duration: 320)])
        #expect(TripSummaryCalculator.summary(for: marathon).exceedsDayLimit)

        let reasonable = TripPlan(places: [place(duration: 120), place(duration: 120)])
        #expect(TripSummaryCalculator.summary(for: reasonable).exceedsDayLimit == false)
    }

    @Test("Cost and category breakdown are totalled from the plan")
    func costAndBreakdown() {
        let plan = TripPlan(places: [
            place(category: .landmark, price: .medium),
            place(category: .landmark, price: .low),
            place(category: .cafe, price: .free)
        ])
        let summary = TripSummaryCalculator.summary(for: plan)

        #expect(summary.totalCostUSD == 22 + 7 + 0)
        #expect(summary.categoryBreakdown == [
            CategoryCount(category: .landmark, count: 2),
            CategoryCount(category: .cafe, count: 1)
        ])
    }

    private func place(
        category: PlaceCategory = .landmark,
        duration: Int = 60,
        distanceKm: Double = 1,
        price: PriceLevel = .medium
    ) -> Place {
        Place(
            id: UUID().uuidString,
            name: "Test place",
            category: category,
            rating: 4.5,
            imageURL: URL(string: "https://picsum.photos/seed/test/400/300")!,
            estimatedDurationMinutes: duration,
            distanceKm: distanceKm,
            description: "A place.",
            openingHours: "9:00 AM - 6:00 PM",
            priceLevel: price,
            tags: []
        )
    }
}
