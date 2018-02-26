import Foundation

/// Value object representing a movie.
struct Movie: Decodable {
    let title: String?
    let releaseDate: Date?
    let posterPath: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        posterPath = try container.decode(String.self, forKey: .posterPath)

        let dateString = try container.decode(String.self, forKey: .releaseDate)
        releaseDate = Movie.yyyyMMdd.date(from: dateString)
    }

    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    enum CodingKeys: String, CodingKey {
        case releaseDate = "release_date"
        case title = "title"
        case posterPath = "poster_path"
    }
}
