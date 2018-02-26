import Quick
import Nimble
@testable import TMDbKit

class ResourceTests: QuickSpec {
    override func spec() {
        describe("A resource") {
            context("when creating a request") {
                var request: URL?

                beforeEach {
                    let resource = Resource(basePath: URL(string: "https://api.themoviedb.org/3/")!,
                                            path: "search/movie",
                                            parameters: ["api_key": "api_key", "query": "bat man"])
                    request = resource.request()
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
        }
    }
}
