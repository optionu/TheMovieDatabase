import UIKit

protocol TableDisplaySupportDelegate: class {
    func tableDisplaySupportLoadNextPage(_ tableDisplaySupport: TableDisplaySupport)
}

class TableDisplaySupport: NSObject, UITableViewDelegate {
    weak var delegate: TableDisplaySupportDelegate?

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            delegate?.tableDisplaySupportLoadNextPage(self)
        }
    }
}
