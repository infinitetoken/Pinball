import XCTest
@testable import Pinball

final class PinballTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Pinball().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
