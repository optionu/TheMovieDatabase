import UIKit
import TMDbKit

protocol DataSourceDelegate: class {
    func dataSourceNeedsTableReload(_ dataSource: DataSource)
    func dataSourceNeeds(_ dataSource: DataSource, showAlertWith message: String)
}

class DataSource: NSObject {
    let client: Client
    weak var delegate: DataSourceDelegate?

    var searchTerm: String?
    var currentPage: Page?
    var movies = [Movie]()

    init(client: Client) {
        self.client = client
    }

    func loadFirst(searchTerm: String?) {
        if let searchTerm = searchTerm {
            self.searchTerm = searchTerm
            load(page: 1)
        }
    }

    func loadNext() {
        if let nextPage = currentPage?.nextPage() {
            load(page: nextPage)
        }
    }

    private func load(page: Int) {
        guard let searchTerm = searchTerm else {
            return
        }

        client.search(searchTerm: searchTerm, page: page) { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let page):
                if page.pageNumber == 1 {
                    strongSelf.movies.removeAll()
                }
                strongSelf.currentPage = page
                strongSelf.movies.append(contentsOf: page.movies)
                strongSelf.delegate?.dataSourceNeedsTableReload(strongSelf)

                if page.movies.isEmpty {
                    strongSelf.delegate?.dataSourceNeeds(strongSelf, showAlertWith: "error.empty_results".localized)
                }
            case .failure:
                strongSelf.delegate?.dataSourceNeeds(strongSelf, showAlertWith: "error.network".localized)
            }
        }
    }
}

extension DataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = nil

        return cell
    }
}
