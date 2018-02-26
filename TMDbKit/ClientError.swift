import Foundation

/// Errors that the TMDb client might run into.
public enum ClientError: Error {
    case invalidJSON
    case invalidImage
    case invalidURL
    case invalidData
    case requestFailed
}
