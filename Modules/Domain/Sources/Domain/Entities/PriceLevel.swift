public enum PriceLevel: Sendable {
    case free
    case low
    case medium
    case high

    public init(symbol: String) {
        switch symbol.filter({ $0 == "$" }).count {
        case 1: self = .low
        case 2: self = .medium
        case 3...: self = .high
        default: self = .free
        }
    }

    public var symbol: String {
        switch self {
        case .free: "Free"
        case .low: "$"
        case .medium: "$$"
        case .high: "$$$"
        }
    }

    // Rough per-person estimate used for the trip cost total.
    public var estimatedCostUSD: Int {
        switch self {
        case .free: 0
        case .low: 7
        case .medium: 22
        case .high: 48
        }
    }
}
