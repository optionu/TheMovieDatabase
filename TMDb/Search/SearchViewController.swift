import UIKit
import TMDbKit

/// Search view controller that acts as a hub between different classes that
/// implement the actual functionality.
class SearchViewController: UITableViewController {
    let client = Client(baseURL: URL(string: "https://api.themoviedb.org/3/")!,
                        baseURLImage: URL(string: "https://image.tmdb.org/")!,
                        accessToken: "2696829a81b1b5827d515ff121700838")

    var searchController: UISearchController?
    var searchResultsController: SearchResultsController?
    let searchHistory = SearchHistory()
    var dataSource: SearchDataSource?
    let tableDisplaySupport = SearchTableDisplaySupport()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "search.title".localized

        searchResultsController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: SearchResultsController.self)) as? SearchResultsController
        searchResultsController?.delegate = self
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController?.searchResultsUpdater = searchResultsController
        searchController?.dimsBackgroundDuringPresentation = false;
        tableView.tableHeaderView = searchController?.searchBar
        searchController?.searchBar.delegate = self;
        definesPresentationContext = true

        let dataSource = SearchDataSource(client: client)
        dataSource.delegate = self
        tableView.dataSource = dataSource
        self.dataSource = dataSource

        tableView.delegate = tableDisplaySupport
        tableDisplaySupport.delegate = self
    }

    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "error.title".localized, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "error.ok".localized, style: .default, handler: nil)
        alertController.addAction(defaultAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        dataSource?.loadFirst(searchTerm: searchBar.text)
        searchController?.isActive = false
    }
}

extension SearchViewController: SearchResultsControllerDelegate {
    func searchResultsController(_ searchResultsController: SearchResultsController, searchFor searchTerm: String) {
        dataSource?.loadFirst(searchTerm: searchTerm)
        searchController?.isActive = false
    }
}

extension SearchViewController: SearchDataSourceDelegate {
    func searchDataSourceNeedsTableReload(_ searchDataSource: SearchDataSource) {
        tableView.reloadData()
    }

    func searchDataSource(_ searchDataSource: SearchDataSource, showAlertWith message: String) {
        showAlert(message)
    }

    func searchDataSource(_ searchDataSource: SearchDataSource, successfulSearchWith searchTerm: String) {
        searchResultsController?.add(searchTerm)
    }
}

extension SearchViewController: SearchTableDisplaySupportDelegate {
    func searchTableDisplaySupportLoadNextPage(_ searchTableDisplaySupport: SearchTableDisplaySupport) {
        dataSource?.loadNext()
    }
}
