import Foundation

/// Keeps a history of search items.
class SearchHistory {
    let persistence: HistoryPersistence
    let maxNumberOfItems: Int

    var items: [String] {
        get {
            return persistence.read()
        }
    }

    init(maxNumberOfItems: Int = 10, persistence: HistoryPersistence = UserDefaultsPersistence()) {
        self.persistence = persistence
        self.maxNumberOfItems = maxNumberOfItems
    }

    func add(_ item: String) {
        var items = persistence.read()
            .filter { $0 != item }
        items.insert(item, at: 0)
        items = Array(items.prefix(maxNumberOfItems))
        persistence.write(items: items)
    }
}
