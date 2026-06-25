import Foundation

public struct Place: Identifiable, Equatable, Sendable {
    public let id: String
    public let name: String
    public let category: PlaceCategory
    public let rating: Double
    public let imageURL: URL
    public let estimatedDurationMinutes: Int
    public let distanceKm: Double
    public let description: String
    public let openingHours: String
    public let priceLevel: PriceLevel
    public let tags: [String]

    public init(
        id: String,
        name: String,
        category: PlaceCategory,
        rating: Double,
        imageURL: URL,
        estimatedDurationMinutes: Int,
        distanceKm: Double,
        description: String,
        openingHours: String,
        priceLevel: PriceLevel,
        tags: [String]
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.rating = rating
        self.imageURL = imageURL
        self.estimatedDurationMinutes = estimatedDurationMinutes
        self.distanceKm = distanceKm
        self.description = description
        self.openingHours = openingHours
        self.priceLevel = priceLevel
        self.tags = tags
    }
}
