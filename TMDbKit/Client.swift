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
}
