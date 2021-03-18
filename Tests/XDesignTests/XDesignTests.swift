import XCTest
@testable import XDesign

final class XDesignTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(XDesign().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
