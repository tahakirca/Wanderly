import Foundation
import Domain

// Sample data used only by SwiftUI previews in this module.
extension Place {
    static let preview = Place(
        id: "hawa-mahal",
        name: "Hawa Mahal",
        category: .landmark,
        rating: 4.8,
        imageURL: URL(string: "https://picsum.photos/seed/wanderly-1/900/700")!,
        estimatedDurationMinutes: 90,
        distanceKm: 2.4,
        description: "The Palace of Winds, a five-storey pink sandstone facade with 953 tiny windows.",
        openingHours: "9:00 AM - 5:30 PM",
        priceLevel: .low,
        tags: ["architecture", "photo spot", "history"]
    )
}
