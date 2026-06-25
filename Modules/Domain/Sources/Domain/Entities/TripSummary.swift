public struct ScheduledStop: Identifiable, Equatable, Sendable {
    public let place: Place
    public let order: Int
    public let arrivalMinutes: Int
    public let travelMinutesBefore: Int

    public init(place: Place, order: Int, arrivalMinutes: Int, travelMinutesBefore: Int) {
        self.place = place
        self.order = order
        self.arrivalMinutes = arrivalMinutes
        self.travelMinutesBefore = travelMinutesBefore
    }

    public var id: String {
        place.id
    }

    public var departureMinutes: Int {
        arrivalMinutes + place.estimatedDurationMinutes
    }
}

public struct CategoryCount: Equatable, Sendable {
    public let category: PlaceCategory
    public let count: Int

    public init(category: PlaceCategory, count: Int) {
        self.category = category
        self.count = count
    }
}

public struct TripSummary: Equatable, Sendable {
    public static let dayLimitMinutes = 600

    public let stops: [ScheduledStop]
    public let startMinutes: Int
    public let endMinutes: Int
    public let totalCostUSD: Int
    public let categoryBreakdown: [CategoryCount]

    public init(
        stops: [ScheduledStop],
        startMinutes: Int,
        endMinutes: Int,
        totalCostUSD: Int,
        categoryBreakdown: [CategoryCount]
    ) {
        self.stops = stops
        self.startMinutes = startMinutes
        self.endMinutes = endMinutes
        self.totalCostUSD = totalCostUSD
        self.categoryBreakdown = categoryBreakdown
    }

    public var stopCount: Int {
        stops.count
    }

    public var totalDurationMinutes: Int {
        endMinutes - startMinutes
    }

    public var exceedsDayLimit: Bool {
        totalDurationMinutes > TripSummary.dayLimitMinutes
    }
}
