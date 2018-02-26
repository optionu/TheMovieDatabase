import Foundation

/// Value object representing a page of movie data.
struct Page: Decodable {
    let pageNumber: Int
    let totalNumberOfPages: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case totalNumberOfPages = "total_pages"
        case movies = "results"
    }
}
