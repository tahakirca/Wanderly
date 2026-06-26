public struct TripPlan: Equatable, Sendable {
    public static let defaultStartMinutes = 9 * 60

    public var places: [Place]
    public let startMinutes: Int

    public init(places: [Place] = [], startMinutes: Int = TripPlan.defaultStartMinutes) {
        self.places = places
        self.startMinutes = startMinutes
    }

    public var isEmpty: Bool {
        places.isEmpty
    }

    public func contains(_ place: Place) -> Bool {
        places.contains { $0.id == place.id }
    }
}
