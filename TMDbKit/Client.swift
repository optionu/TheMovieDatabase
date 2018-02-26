import Foundation

/// TMDb client.
public class Client {
    public let baseURL: URL
    public let baseURLImage: URL
    public let accessToken: String
    public let session: URLSession
    public let timeoutInterval: TimeInterval

    public init(baseURL: URL,
                baseURLImage: URL,
                accessToken: String,
                session: URLSession = .shared,
                timeoutInterval: TimeInterval = 30) {
        self.baseURL = baseURL
        self.baseURLImage = baseURLImage
        self.accessToken = accessToken
        self.session = session
        self.timeoutInterval = timeoutInterval
    }

    public func search(searchTerm: String, completion: @escaping (Result<Page>) -> Void) {
        let resource = Resource<Page>(basePath: baseURL,
                                      path: "search/movie",
                                      parameters: ["api_key": accessToken, "query": searchTerm, "page": "1"],
                                      parse: parseJSON)
        runRequest(for: resource, completion: completion)
    }

    public func loadImage(imagePath: String, completion: @escaping (Result<UIImage>) -> Void) {
        let resource = Resource<UIImage>(basePath: baseURLImage,
                                         path: "t/p/w92" + imagePath,
                                         parameters: [:],
                                         parse: parseImage)
        runRequest(for: resource, completion: completion)
    }

    func runRequest<Model>(for resource: Resource<Model>, completion: @escaping (Result<Model>) -> Void) {
        guard let url = resource.request() else {
                completion(.failure(ClientError.invalidURL))
                return
        }

        let urlRequest = URLRequest(url: url, timeoutInterval: timeoutInterval)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(ClientError.invalidData))
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
                else {
                    completion(.failure(ClientError.requestFailed))
                    return
            }

            let result = resource.parse(data)
            DispatchQueue.main.async {
                completion(result)
            }
        }

        task.resume()
    }
}
