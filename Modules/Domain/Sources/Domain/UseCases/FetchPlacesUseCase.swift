public protocol FetchPlacesUseCase: Sendable {
    func execute() async throws -> [Place]
}

public struct FetchPlacesUseCaseImpl: FetchPlacesUseCase {
    private let repository: PlacesRepository

    public init(repository: PlacesRepository) {
        self.repository = repository
    }

    public func execute() async throws -> [Place] {
        try await repository.loadPlaces()
    }
}
