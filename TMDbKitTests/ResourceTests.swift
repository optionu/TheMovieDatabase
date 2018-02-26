import Quick
import Nimble
@testable import TMDbKit

class ResourceTests: QuickSpec {
    override func spec() {
        describe("A resource") {
            struct Model: Decodable {
                let name: String
            }

            var resource: Resource<Model>?

            beforeEach {
                resource = Resource<Model>(basePath: URL(string: "https://api.themoviedb.org/3/")!,
                                            path: "search/movie",
                                            parameters: ["api_key": "api_key", "query": "bat man"],
                                            parse: parseJSON)
            }

            context("when creating a request") {
                var request: URL?

                beforeEach {
                    request = resource?.request()
                }

                it("has the right path") {
                    expect(request?.absoluteString).to(beginWith("https://api.themoviedb.org/3/search/movie?"))
                }

                it("contains query parameter") {
                    expect(request?.absoluteString).to(contain("api_key=api_key"))
                }

                it("escapes query parameter") {
                    expect(request?.absoluteString).to(contain("query=bat%20man"))
                }
            }

            context("when parsing data") {
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
}
