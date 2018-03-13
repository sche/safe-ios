//
//  Copyright © 2018 Gnosis. All rights reserved.
//

import XCTest
@testable import safe

class CrashlyticsLoggerTests: XCTestCase {

    var logger: CrashlyticsLogger!
    let mockCrashlytics = MockCrashlytics()
    let testMessage = "Test Error"

    override func setUp() {
        super.setUp()
        logger = CrashlyticsLogger(crashlytics: mockCrashlytics)
    }

    func test_whenLoggingWithoutError_thenNothingHappens() {
        logger.log(testMessage, level: .error, error: nil, file: "", line: 0, function: "")
        XCTAssertNil(mockCrashlytics.loggedError)
    }

    func test_whenLoggingWithError_thenLogged() {
        logger.log(testMessage, level: .error, error: TestError.error, file: "", line: 0, function: "")
        XCTAssertEqual(mockCrashlytics.loggedError?.localizedDescription, TestError.error.localizedDescription)
    }

    func test_whenLoggingWithError_thenUserInfoHasMessage() {
        logger.log(testMessage, level: .error, error: TestError.error, file: "", line: 0, function: "")
        XCTAssertEqual((mockCrashlytics.loggedError as NSError?)?.userInfo.count, 1)
        XCTAssertEqual((mockCrashlytics.loggedError as NSError?)?.userInfo["message"] as? String, testMessage)
    }

}

enum TestLogError: LoggableError {
    case error
}

class MockCrashlytics: CrashlyticsProtocol {

    var loggedError: Error?

    func recordError(_ error: Error) {
        loggedError = error
    }

}
