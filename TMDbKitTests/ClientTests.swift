import Quick
import Nimble
@testable import TMDbKit

class ClientTests: QuickSpec {
    override func spec() {
        describe("A client") {
            context("when creating a client") {
                var client: Client?

                beforeEach {
                    client = Client(baseURL: URL(string: "http://api.themoviedb.org/3/")!,
                                    baseURLImage: URL(string: "https://image.tmdb.org/")!,
                                    accessToken: "accessToken")
                }

                it("has the right values") {
                    expect(client?.baseURL.absoluteString).to(equal("http://api.themoviedb.org/3/"))
                    expect(client?.baseURLImage.absoluteString).to(equal("https://image.tmdb.org/"))
                    expect(client?.accessToken).to(equal("accessToken"))
                }

                it("has the right default values") {
                    expect(client?.timeoutInterval).to(equal(30))
                    expect(client?.session).to(equal(URLSession.shared))
                }
            }

            context("when executing a request") {
                struct Model: Decodable {
                    let name: String
                }

                var client: Client?
                var session: URLSessionMock?
                var resource: Resource<Model>?

                beforeEach {
                    session = URLSessionMock()
                    client = Client(baseURL: URL(string: "http://api.themoviedb.org/3/")!,
                                    baseURLImage: URL(string: "https://image.tmdb.org/")!,
                                    accessToken: "accessToken",
                                    session: session!)
                    resource = Resource<Model>(basePath: URL(string: "https://api.themoviedb.org/3/")!,
                                               path: "",
                                               parameters: [:],
                                               parse: parseJSON)
                }

                it("it calls the completion handler for valid data") {
                    session?.data = "{ \"name\": \"name\" }".data(using: .utf8)!
                    var result: Result<Model>?
                    client?.runRequest(for: resource!) { result = $0 }
                    expect(result).toNot(beNil())
                }

                it("it calls the completion handler for errors") {
                    session?.error = NSError(domain: "domain", code: 1)
                    var result: Result<Model>?
                    client?.runRequest(for: resource!) { result = $0 }
                    expect(result).toNot(beNil())
                }
            }
        }
    }
}

