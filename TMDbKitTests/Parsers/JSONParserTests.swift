import Quick
import Nimble
@testable import TMDbKit

class JSONParserTests: QuickSpec {
    override func spec() {
        describe("The JSON parser") {
            context("when using a simple model") {
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

                it("can parse data") {
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

            context("when using a search model") {
                var resource: Resource<Page>?

                beforeEach {
                    resource = Resource<Page>(basePath: URL(string: "https://api.themoviedb.org/3/")!,
                                              path: "",
                                              parameters: [:],
                                              parse: parseJSON)
                }

                it("can parse search results") {
                    let bundle = Bundle.init(for: ResourceTests.self)
                    let path = bundle.path(forResource: "search_results.json", ofType: nil)!
                    let data = try? Data(contentsOf: URL(fileURLWithPath: path))

                    guard let result = resource?.parse(data!) else {
                        fail("invalid result")
                        return
                    }

                    switch (result) {
                    case .success(let model):
                        let releaseDate = Movie.yyyyMMdd.date(from: "1989-06-23")

                        expect(model.pageNumber).to(equal(1))
                        expect(model.totalNumberOfPages).to(equal(6))
                        expect(model.movies.count).to(equal(20))
                        expect(model.movies.first?.title).to(equal("Batman"))
                        expect(model.movies.first?.releaseDate).to(equal(releaseDate))
                        expect(model.movies.first?.posterPath).to(equal("/kBf3g9crrADGMc2AMAMlLBgSm2h.jpg"))
                        expect(model.movies.first?.overview).to(beginWith("The Dark Knight of Gotham City"))
                    case .failure: fail("invalid result")
                    }
                }
            }
        }
    }
}
