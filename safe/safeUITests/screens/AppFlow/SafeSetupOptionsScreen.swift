//
//  Copyright © 2018 Gnosis. All rights reserved.
//

import Foundation
import XCTest

final class SetupSafeOptionsScreen {

    var isDisplayed: Bool {
        return XCUIApplication().staticTexts[XCLocalizedString("onboarding.setup_safe.info")].exists
    }

}
