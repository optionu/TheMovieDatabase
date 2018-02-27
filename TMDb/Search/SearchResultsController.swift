import UIKit

protocol SearchResultsControllerDelegate: class {
    func searchResultsController(_ searchResultsController: SearchResultsController, searchFor searchTerm: String)
}

class SearchResultsController: UITableViewController {
    let searchHistory = SearchHistory()
    weak var delegate: SearchResultsControllerDelegate?

    func add(_ item: String) {
        searchHistory.add(item)
        tableView.reloadData()
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Always show results table
        searchController.searchResultsController?.view.isHidden = false
    }
}

extension SearchResultsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = searchHistory.items[indexPath.row]

        return cell
    }
}

extension SearchResultsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchHistory.items[indexPath.row]
        delegate?.searchResultsController(self, searchFor: item)
    }
}
