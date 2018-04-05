//
//  Copyright © 2018 Gnosis. All rights reserved.
//

import UIKit

protocol AppFlowCoordinatorProtocol: class {

    func startViewController() -> UIViewController
    func appEntersForeground()

}

final class AppFlowCoordinator: AppFlowCoordinatorProtocol {

    let onboardingFlowCoordinator: OnboardingFlowCoordinator
    private var lockedViewController: UIViewController!
    private let authenticationService: AuthenticationApplicationService

    private var rootViewController: UIViewController? {
        get { return UIApplication.shared.keyWindow?.rootViewController }
        set { UIApplication.shared.keyWindow?.rootViewController = newValue }
    }

    private var shouldLockWhenAppActive: Bool { return authenticationService.isUserAuthenticated() }

    init(account: AccountProtocol = Account.shared) {
        authenticationService = AuthenticationApplicationService(account: account)
        onboardingFlowCoordinator = OnboardingFlowCoordinator(account: account)
    }

    func startViewController() -> UIViewController {
        lockedViewController = onboardingFlowCoordinator.startViewController()
        if authenticationService.isUserRegistered() {
            return unlockController { [unowned self] in
                self.rootViewController = self.lockedViewController
            }
        }
        return lockedViewController
    }

    func unlockController(completion: @escaping () -> Void) -> UIViewController {
        return UnlockViewController.create(account: authenticationService.account, completion: completion)
    }

    func appEntersForeground() {
        guard let rootVC = self.rootViewController, !(rootVC is UnlockViewController) && shouldLockWhenAppActive else {
            return
        }
        lockedViewController = rootVC
        self.rootViewController = unlockController { [unowned self] in
            self.rootViewController = self.lockedViewController
        }
    }

}
