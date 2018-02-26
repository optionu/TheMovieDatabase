import Foundation

/// Parse JSON from data object.
func parseJSON<Model: Decodable>(data: Data) -> Result<Model> {
    let decoder = JSONDecoder()
    guard
        let model = try? decoder.decode(Model.self, from: data) else {
            return .failure(ClientError.invalidJSON)
    }

    return .success(model)
}
