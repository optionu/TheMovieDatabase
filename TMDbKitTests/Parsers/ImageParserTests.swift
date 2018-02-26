import Quick
import Nimble
@testable import TMDbKit

class ImageParserTests: QuickSpec {
    override func spec() {
        describe("The image parser") {
            var resource: Resource<UIImage>?

            beforeEach {
                resource = Resource<UIImage>(basePath: URL(string: "https://api.themoviedb.org/3/")!,
                                           path: "",
                                           parameters: [:],
                                           parse: parseImage)
            }

            it("can parse image data") {
                let bundle = Bundle.init(for: ResourceTests.self)
                let path = bundle.path(forResource: "2DtPSyODKWXluIRV7PVru0SSzja.jpg", ofType: nil)!
                let data = try? Data(contentsOf: URL(fileURLWithPath: path))

                guard let result = resource?.parse(data!) else {
                    fail("invalid result")
                    return
                }

                switch (result) {
                case .success(let image): expect(image).toNot(beNil())
                case .failure: fail("invalid result")
                }
            }
        }
    }
}

