struct GetMovieListUseCaseInput {
    let category: String
}

final class GetMovieListUseCase {
    private let repository: MovieRepositoryType

    init(repository: MovieRepositoryType) {
        self.repository = repository
    }

    func execute(input: GetMovieListUseCaseInput) async throws -> [Movie] {
        guard let category = Category(rawValue: input.category) else {
            throw MovieError.invalidCategory
        }
        return try await repository.getMovieList(category: category)
    }
}
