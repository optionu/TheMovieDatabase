import Foundation

extension String {
    /// Returns the localized string.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
