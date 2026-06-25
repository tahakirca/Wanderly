import Domain
import Testing
@testable import Data

@Suite("LocalPlacesRepository")
struct LocalPlacesRepositoryTests {
    @Test func loadsAllBundledPlaces() async throws {
        let places = try await LocalPlacesRepository().loadPlaces()
        #expect(places.count == 35)
    }

    @Test func categoryCountsMatchTheFile() async throws {
        let places = try await LocalPlacesRepository().loadPlaces()
        func count(_ category: PlaceCategory) -> Int {
            places.filter { $0.category == category }.count
        }
        #expect(count(.landmark) == 15)
        #expect(count(.restaurant) == 6)
        #expect(count(.cafe) == 5)
        #expect(count(.activity) == 7)
        #expect(count(.shopping) == 2)
    }
}
