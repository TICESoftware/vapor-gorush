import XCTest
@testable import Gorush

final class GorushTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(Gorush().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
