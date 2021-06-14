import XCTest
@testable import CryptoApiLib

final class CryptoApiLibTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CryptoApiLib().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
