import UIKit
import TMDbKit

class DataSource: NSObject, UITableViewDataSource {
    var page: Page?

    func update(with page: Page) {
        self.page = page
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return page?.movies.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let movie = page?.movies[indexPath.row]
        cell.textLabel?.text = movie?.title
        cell.detailTextLabel?.text = nil

        return cell
    }
}
