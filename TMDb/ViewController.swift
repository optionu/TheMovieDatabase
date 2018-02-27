import UIKit
import TMDbKit

class ViewController: UITableViewController {
    let client = Client(baseURL: URL(string: "https://api.themoviedb.org/3/")!,
                        baseURLImage: URL(string: "https://image.tmdb.org/")!,
                        accessToken: "2696829a81b1b5827d515ff121700838")

    let searchController = UISearchController(searchResultsController: nil)
    var searchResultsUpdater: SearchResultsUpdater?

    let dataSource = DataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultsUpdater = SearchResultsUpdater(client: client)
        searchResultsUpdater?.delegate = self

        searchController.dimsBackgroundDuringPresentation = false;
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = searchResultsUpdater;
        definesPresentationContext = true

        tableView.dataSource = dataSource
    }

    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)

        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: SearchResultsUpdaterDelegate{
    func searchResultsUpdater(_ searchResultsUpdater: SearchResultsUpdater, didFindResult result: Result<Page>) {
        searchController.isActive = false

        switch result {
        case .success(let model):
            dataSource.update(with: model)
            tableView.reloadData()
            if model.movies.isEmpty {
                showAlert("empty")
            }
        case .failure:
            showAlert("failure")
        }
    }
}
