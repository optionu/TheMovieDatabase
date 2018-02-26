import Foundation

/// Value representing the result of a client operation.
public enum Result<Model> {
    case success(Model)
    case failure(Error)
}
