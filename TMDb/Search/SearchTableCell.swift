import UIKit
import TMDbKit

class SearchTableCell: UITableViewCell {
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterView: UIImageView!
    private var posterPath: String?

    func configure(_ movie: Movie, client: Client) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        subtitleLabel.text = movie.releaseDate.flatMap(formatter.string)

        if let posterPath = movie.posterPath {
            loadImage(for: posterPath, client: client)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterView.image = nil
    }

    private func loadImage(for posterPath: String, client: Client) {
        self.posterPath = posterPath
        client.loadImage(imagePath: posterPath) { [weak self] result, path in
            guard let strongSelf = self,
                case .success(let image) = result,
                let posterPath = strongSelf.posterPath,
                path.hasSuffix(posterPath)
                else {
                return
            }

            strongSelf.posterView.image = image
        }
    }
}
