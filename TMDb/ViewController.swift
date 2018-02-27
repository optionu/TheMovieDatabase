import UIKit
import TMDbKit

/// Search view controller that acts as a hub between different classes that
/// implement the actual functionality.
class ViewController: UITableViewController {
    let client = Client(baseURL: URL(string: "https://api.themoviedb.org/3/")!,
                        baseURLImage: URL(string: "https://image.tmdb.org/")!,
                        accessToken: "2696829a81b1b5827d515ff121700838")

    let searchController = UISearchController(searchResultsController: nil)

    var dataSource: DataSource?
    let tableDisplaySupport = TableDisplaySupport()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "search.title".localized

        searchController.dimsBackgroundDuringPresentation = false;
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self;
        definesPresentationContext = true

        let dataSource = DataSource(client: client)
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

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        dataSource?.loadFirst(searchTerm: searchBar.text)
        searchController.isActive = false
    }
}

extension ViewController: DataSourceDelegate {
    func dataSourceNeedsTableReload(_ dataSource: DataSource) {
        tableView.reloadData()
    }

    func dataSourceNeeds(_ dataSource: DataSource, showAlertWith message: String) {
        showAlert(message)
    }
}

extension ViewController: TableDisplaySupportDelegate {
    func tableDisplaySupportLoadNextPage(_ tableDisplaySupport: TableDisplaySupport) {
        dataSource?.loadNext()
    }
}
