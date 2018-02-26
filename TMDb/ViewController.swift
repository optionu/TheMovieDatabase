import UIKit
import TMDbKit

class ViewController: UIViewController {
    let client = Client(baseURL: URL(string: "https://api.themoviedb.org/3/")!,
                        baseURLImage: URL(string: "https://image.tmdb.org/")!,
                        accessToken: "2696829a81b1b5827d515ff121700838")

    override func viewDidLoad() {
        super.viewDidLoad()

        loadMovies()
    }

    func loadMovies() {
        client.search(searchTerm: "batman") { result in
            switch (result) {
            case .success(let page):
                print("Successfully retrieved \(page.movies.count) movie(s)")
                if let posterPath = page.movies.first?.posterPath {
                    self.loadImage(imagePath: posterPath)
                }
            case .failure(let error): print("Error \(error)")
            }
        }
    }

    func loadImage(imagePath: String) {
        client.loadImage(imagePath: imagePath) { result in
            switch (result) {
            case .success:
                print("Successfully loaded image \(imagePath)")
            case .failure(let error): print("Error \(error)")
            }
        }
    }
}
