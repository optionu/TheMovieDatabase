import Foundation

/// Value object representing a page of movie data.
public struct Page: Decodable {
    public let pageNumber: Int
    public let totalNumberOfPages: Int
    public let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case totalNumberOfPages = "total_pages"
        case movies = "results"
    }
}
