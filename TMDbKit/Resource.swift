import Foundation

/// A value describing a REST endpoint.
struct Resource {
    let basePath: URL
    let path: String
    let parameters: [String: String]

    /// Returns request URL based on resource parameters.
    func request() -> URL? {
        guard
            let url = URL(string: path, relativeTo: basePath),
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }

        let queryItems = parameters.map { URLQueryItem.init(name: $0.key, value: $0.value) }
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }
}
