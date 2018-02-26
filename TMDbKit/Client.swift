import Foundation

/// TMDb client.
public class Client {
    let baseURL: URL
    let accessToken: String
    let session: URLSession
    let timeoutInterval: TimeInterval

    init(baseURL: URL,
         accessToken: String,
         session: URLSession = .shared,
         timeoutInterval: TimeInterval = 30) {
        self.baseURL = baseURL
        self.accessToken = accessToken
        self.session = session
        self.timeoutInterval = timeoutInterval
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
