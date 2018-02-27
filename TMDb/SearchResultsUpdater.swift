import UIKit
import TMDbKit

protocol SearchResultsUpdaterDelegate: class {
    func searchResultsUpdater(_ searchResultsUpdater: SearchResultsUpdater, didFindResult result: Result<Page>)
}

class SearchResultsUpdater: NSObject, UISearchBarDelegate {
    let client: Client
    weak var delegate: SearchResultsUpdaterDelegate?

    init(client: Client) {
        self.client = client
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            client.search(searchTerm: searchTerm) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }

                strongSelf.delegate?.searchResultsUpdater(strongSelf, didFindResult: result)
            }
        }
    }
}
