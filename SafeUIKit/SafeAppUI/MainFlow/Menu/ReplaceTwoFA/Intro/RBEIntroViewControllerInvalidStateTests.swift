//
//  Copyright © 2019 Gnosis Ltd. All rights reserved.
//

import XCTest
@testable import SafeAppUI
import Common
import BigInt
import MultisigWalletApplication

class RBEIntroViewControllerInvalidStateTests: RBEIntroViewControllerBaseTestCase {

    func test_whenInvalid_thenShowsError() {
        let error = FeeCalculationError.insufficientBalance
        vc.calculationData = RBEFeeCalculationData(currentBalance: TokenData.Ether.withBalance(BigInt(3e18)),
                                                   networkFee: TokenData.Ether.withBalance(BigInt(-4e18)),
                                                   balance: TokenData.Ether.withBalance(BigInt(-1e18)))
        vc.disableRetry()
        vc.transition(to: RBEIntroViewController.InvalidState(error: error))
        XCTAssertEqual(vc.feeCalculation.currentBalanceLine.asset.value, "3 ETH")
        XCTAssertEqual(vc.feeCalculation.networkFeeLine.asset.value, "-")
        XCTAssertEqual(vc.feeCalculation.resultingBalanceLine.asset.value, "-1 ETH")
        XCTAssertEqual(vc.feeCalculation.resultingBalanceLine.asset.error as? FeeCalculationError, error)
        XCTAssertEqual(vc.feeCalculation.errorLine.text, error.localizedDescription)
        XCTAssertNil(vc.navigationItem.titleView)
        XCTAssertTrue(vc.retryButtonItem.isEnabled)
        XCTAssertEqual(vc.navigationItem.rightBarButtonItems, [vc.retryButtonItem])
    }

    func test_whenOhterError_thenDisplaysIt() {
        let error = NSError(domain: NSURLErrorDomain,
                            code: NSURLErrorTimedOut,
                            userInfo: [NSLocalizedDescriptionKey: "Request timed out"])
        vc.transition(to: RBEIntroViewController.InvalidState(error: error))
        XCTAssertEqual(vc.feeCalculation.errorLine.text, error.localizedDescription)
        XCTAssertNil(vc.feeCalculation.resultingBalanceLine.asset.error)
    }

}
