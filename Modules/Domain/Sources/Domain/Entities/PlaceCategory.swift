public enum PlaceCategory: String, CaseIterable, Sendable {
    case landmark
    case restaurant
    case cafe
    case activity
    case shopping

    public var title: String {
        switch self {
        case .landmark: "Landmarks"
        case .restaurant: "Eat"
        case .cafe: "Cafes"
        case .activity: "Activities"
        case .shopping: "Shopping"
        }
    }
}
