import Foundation

/// Classes that act as persistence store for SearchHistory need to implement
/// this protocol
protocol HistoryPersistence {
    func write(items: [String])
    func read() -> [String]
}
