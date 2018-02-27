import Foundation
@testable import TMDb

/// Implementation of HistoryPersistence using an in-memory store.
class MockPersistence: HistoryPersistence {
    var items = [String]()

    func write(items: [String]) {
        self.items = items
    }

    func read() -> [String] {
        return items
    }
}
