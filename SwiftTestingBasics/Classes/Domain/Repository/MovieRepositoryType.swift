protocol MovieRepositoryType {
    func getMovieList(category: Category) async throws -> [Movie]
}
