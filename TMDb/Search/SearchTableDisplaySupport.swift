import UIKit

protocol SearchTableDisplaySupportDelegate: class {
    func searchTableDisplaySupportLoadNextPage(_ searchTableDisplaySupport: SearchTableDisplaySupport)
}

class SearchTableDisplaySupport: NSObject, UITableViewDelegate {
    weak var delegate: SearchTableDisplaySupportDelegate?

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            delegate?.searchTableDisplaySupportLoadNextPage(self)
        }
    }
}
