import Testing
@testable import SwiftTestingBasics

final class GetMovieListUseCaseTest {
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
    func getComedyMovies(category: String) async throws {
        let input = GetMovieListUseCaseInput(category: category)
        let movies = [Movie(name: "Movie 1", category: .comedy)]
        repository.movies = movies

        let result = try await sut.execute(input: input)

        #expect(result == movies)
    }

    @Test("Given category is invalid, when execute, then throw error")
    func getMoviesWithInvalidCategory() async {
        let category = "invalid"
        let input = GetMovieListUseCaseInput(category: category)
        var receivedError: Error?

        do {
            _ = try await sut.execute(input: input)
        } catch {
            receivedError = error
        }

        #expect(receivedError as? MovieError == .invalidCategory)
    }
}

final class MovieRepositoryStub: MovieRepositoryType {
    var movies: [Movie] = []

    func getMovieList(category: Category) async throws -> [Movie] {
        movies
    }
}
