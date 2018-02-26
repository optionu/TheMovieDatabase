import Quick
import Nimble
@testable import TMDbKit

class JSONParserTests: QuickSpec {
    override func spec() {
        describe("The JSON parser") {
            struct Model: Decodable {
                let name: String
            }

            var resource: Resource<Model>?

            beforeEach {
                resource = Resource<Model>(basePath: URL(string: "https://api.themoviedb.org/3/")!,
                                             path: "",
                                             parameters: [:],
                                             parse: parseJSON)
            }

            it("can parse JSON data") {
                let data = "{ \"name\": \"name\" }".data(using: .utf8)!
                guard let result = resource?.parse(data) else {
                    fail("invalid result")
                    return
                }

                switch (result) {
                case .success(let model): expect(model.name).to(equal("name"))
                case .failure: fail("invalid result")
                }
            }
        }
    }
}


