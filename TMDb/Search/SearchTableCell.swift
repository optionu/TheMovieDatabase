import UIKit
import TMDbKit

class SearchTableCell: UITableViewCell {
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterView: UIImageView!

    func configure(_ movie: Movie) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        subtitleLabel.text = movie.releaseDate.flatMap(formatter.string)
    }
}
