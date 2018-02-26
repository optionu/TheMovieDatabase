import Quick
import Nimble
@testable import TMDbKit

class ClientTests: QuickSpec {
    override func spec() {
        describe("A client") {
            context("when creating a client") {
                var client: Client?

                beforeEach {
                    client = Client(baseURL: URL(string: "http://api.themoviedb.org/3/")!, accessToken: "accessToken")
                }

                it("has the right values") {
                    expect(client?.baseURL.absoluteString).to(equal("http://api.themoviedb.org/3/"))
                    expect(client?.accessToken).to(equal("accessToken"))
                }

                it("has the right default values") {
                    expect(client?.timeoutInterval).to(equal(30))
                    expect(client?.session).to(equal(URLSession.shared))
                }
            }
        }
    }
}

