import UIKit
import TMDbKit

class ViewController: UIViewController {
    let client = Client(baseURL: URL(string: "https://api.themoviedb.org/3/")!, accessToken: "2696829a81b1b5827d515ff121700838")

    override func viewDidLoad() {
        super.viewDidLoad()

        client.search(searchTerm: "batman") { result in
            switch (result) {
            case .success(let page): print("Successfully retrieved \(page.movies.count) movie(s)")
            case .failure(let error): print("Error \(error)")
            }
        }
    }
}
