import XCTest
import TestSupport

@testable import Lox

class ParserTests: XCTestCase {
  // helper.
  func parse(file: String) throws {
    let path = try TestSupport.path(of: file)
    let src = try Lox.Source(path: path)
    let expectations = TestSupport.output_expect(from: src.content)
    let expectation = expectations.first!
    do {
      let expression = try Lox.Parser.parse(src: src)
      let output = expression.jloxDescription
      XCTAssertEqual(output, expectation)
    } catch let err as Parser.Error {
      XCTFail("\(err)")
    }
  }

  func test_expression() throws {
    try parse(file: "expressions/parse")
  }

  static var allTests = [
    ("expression", test_expression),
  ]
}
