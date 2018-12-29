import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CoordinateTests.allTests),
        testCase(SizeTests.allTests),
        testCase(IntConvenienceTests.allTests),
        testCase(SetConvenienceTests.allTests),
        testCase(ConfigurableTests.allTests),
        testCase(SettableTests.allTests),
        testCase(SizeTests.allTests),
        testCase(PieceConfigurationTests.allTests),
        testCase(PieceTests.allTests),
    ]
}
#endif
