import Foundation

private let KEY = "UserDefaultsPersistence"

/// Implementation of HistoryPersistence using UserDefaults.
class UserDefaultsPersistence: HistoryPersistence {
    let defaults = UserDefaults()

    func write(items: [String]) {
        defaults.set(items, forKey: KEY)
    }

    func read() -> [String] {
        let items = defaults.object(forKey: KEY) as? [String]
        return items ?? [String]()
    }
}
