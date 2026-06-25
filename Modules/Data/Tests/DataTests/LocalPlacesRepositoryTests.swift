import Domain
import Testing
@testable import Data

@Suite("LocalPlacesRepository")
struct LocalPlacesRepositoryTests {
    @Test func loadsAllBundledPlaces() async throws {
        let places = try await LocalPlacesRepository().loadPlaces()
        #expect(places.count == 35)
    }

    @Test func decodedPlacesAreWellFormed() async throws {
        let places = try await LocalPlacesRepository().loadPlaces()
        #expect(places.allSatisfy { !$0.name.isEmpty })
        #expect(places.allSatisfy { (0...5).contains($0.rating) })
        #expect(Set(places.map(\.id)).count == places.count)
    }
}
