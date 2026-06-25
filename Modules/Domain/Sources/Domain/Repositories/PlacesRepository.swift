public protocol PlacesRepository: Sendable {
    func loadPlaces() async throws -> [Place]
}
