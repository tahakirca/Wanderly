import Domain
import Foundation

public struct LocalPlacesRepository: PlacesRepository {
    public init() {}

    public func loadPlaces() async throws -> [Place] {
        guard let url = Bundle.module.url(forResource: "mock_data", withExtension: "json") else {
            throw DataError.missingResource("mock_data.json")
        }
        let data = try Data(contentsOf: url)
        let file = try JSONDecoder().decode(MockDataFile.self, from: data)
        return file.places.compactMap { $0.toDomain() }
    }
}

enum DataError: Error {
    case missingResource(String)
}
