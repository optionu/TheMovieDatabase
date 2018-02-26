import UIKit

/// Parse an image from data.
func parseImage(data: Data) -> Result<UIImage> {
    guard let image = UIImage(data: data) else {
        return .failure(ClientError.invalidImage)
    }

    return .success(image)
}
