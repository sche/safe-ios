//
//  Copyright © 2019 Gnosis Ltd. All rights reserved.
//

import Foundation
import MultisigWalletApplication

class ReplaceTwoFACommand: MenuCommand {

    override var title: String {
        return LocalizedString("ios_replace_browser_extension", comment: "Replace browser extension")
            .replacingOccurrences(of: "\n", with: " ").capitalized
    }

    override var isHidden: Bool {
        return !ApplicationServiceRegistry.replaceTwoFAService.isAvailable
    }

    override init() {
        super.init()
        childFlowCoordinator = ReplaceBrowserExtensionFlowCoordinator()
    }

}