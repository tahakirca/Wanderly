import Domain
import Foundation
import Testing
@testable import Data

@Suite("PlaceDTO")
struct PlaceDTOTests {
    @Test func decodesAndMapsToDomain() throws {
        let json = """
        {
            "id": "p1",
            "name": "Amber Fort",
            "category": "landmark",
            "rating": 4.8,
            "image_url": "https://example.com/amber.jpg",
            "estimated_duration_min": 120,
            "distance_km": 11.2,
            "description": "A hilltop fort.",
            "opening_hours": "8:00 AM - 5:30 PM",
            "price_level": "$$",
            "tags": ["historic", "architecture"]
        }
        """
        let dto = try JSONDecoder().decode(PlaceDTO.self, from: Data(json.utf8))
        let place = try #require(dto.toDomain())

        #expect(place.id == "p1")
        #expect(place.category == .landmark)
        #expect(place.priceLevel == .medium)
        #expect(place.imageURL == URL(string: "https://example.com/amber.jpg"))
        #expect(place.estimatedDurationMinutes == 120)
        #expect(place.tags == ["historic", "architecture"])
    }

    @Test func unknownCategoryReturnsNil() throws {
        let json = """
        {
            "id": "x", "name": "Mystery", "category": "wormhole", "rating": 1.0,
            "image_url": "https://example.com/x.jpg", "estimated_duration_min": 10,
            "distance_km": 1.0, "description": "", "opening_hours": "",
            "price_level": "$", "tags": []
        }
        """
        let dto = try JSONDecoder().decode(PlaceDTO.self, from: Data(json.utf8))
        #expect(dto.toDomain() == nil)
    }
}
