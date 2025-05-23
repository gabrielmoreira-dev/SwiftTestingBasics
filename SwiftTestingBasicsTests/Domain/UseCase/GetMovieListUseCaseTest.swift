import Testing
@testable import SwiftTestingBasics

struct GetMovieListUseCaseTest {
    private lazy var repository: MovieRepositoryStub = {
        MovieRepositoryStub()
    }()

    private lazy var sut: GetMovieListUseCase = {
        GetMovieListUseCase(repository: repository)
    }()

    @Test(
        "Given category is Comedy, when execute, then return movies",
        arguments: ["COMEDY", "DRAMA", "DOCUMENTARY"]
    )
    mutating func getComedyMovies(category: String) async throws {
        let input = GetMovieListUseCaseInput(category: category)
        let category = try #require(Category(rawValue: category))
        let movies = [Movie(name: "Movie 1", category: category)]
        repository.movies = movies

        let result = try await sut.execute(input: input)

        #expect(result == movies)
    }

    @Test("Given category is invalid, when execute, then throw error")
    mutating func getMoviesWithInvalidCategory() async {
        let category = "invalid"
        let input = GetMovieListUseCaseInput(category: category)

        await #expect(throws: MovieError.invalidCategory) {
            try await sut.execute(input: input)
        }
    }
}

final class MovieRepositoryStub: MovieRepositoryType {
    var movies: [Movie] = []

    func getMovieList(category: Category) async throws -> [Movie] {
        movies
    }
}
