struct Movie: Equatable {
    let name: String
    let category: Category
}

enum Category: String, Equatable {
    case comedy = "COMEDY"
    case drama = "DRAMA"
    case documentary = "DOCUMENTARY"
}
