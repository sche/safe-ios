//
//  Copyright © 2019 Gnosis Ltd. All rights reserved.
//

import UIKit
import ReplaceBrowserExtensionUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        push()
    }

    @IBAction func push() {
        let vc = RBEIntroViewController.create()

        let error = NSError(domain: NSURLErrorDomain,
                            code: NSURLErrorTimedOut,
                            userInfo: [NSLocalizedDescriptionKey: "Request timed out"])

        navigationController?.pushViewController(vc, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1200)) {
            // vc does not get loaded yet otherwise
            // driver is needed, really
//            vc.handleError(FeeCalculationError.insufficientBalance)
            vc.handleError(error)
        }
    }

}