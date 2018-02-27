import Quick
import Nimble
@testable import TMDb

class SearchHistoryTests: QuickSpec {
    override func spec() {
        describe("Search history") {
            var searchHistory: SearchHistory?

            beforeEach {
                searchHistory = SearchHistory(maxNumberOfItems: 3, persistence: MockPersistence())
            }

            context("when initialised") {
                it("has no items") {
                    expect(searchHistory?.items).to(beEmpty())
                }
            }

            context("when adding items") {
                it("can add item") {
                    searchHistory?.add("1")
                    expect(searchHistory?.items).to(equal(["1"]))
                }

                it("can add items") {
                    searchHistory?.add("1")
                    searchHistory?.add("2")
                    searchHistory?.add("3")
                    expect(searchHistory?.items).to(equal(["3", "2", "1"]))
                }

                it("can add max number of items") {
                    searchHistory?.add("1")
                    searchHistory?.add("2")
                    searchHistory?.add("3")
                    searchHistory?.add("4")
                    expect(searchHistory?.items).to(equal(["4", "3", "2"]))
                }

                it("duplicate item gets bumped up") {
                    searchHistory?.add("1")
                    searchHistory?.add("2")
                    searchHistory?.add("1")
                    expect(searchHistory?.items).to(equal(["1", "2"]))
                }
            }
        }
    }
}
