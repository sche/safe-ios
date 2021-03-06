//
//  Copyright © 2018 Gnosis Ltd. All rights reserved.
//

import Foundation
import BigInt

extension Double {

    static func value(from number: BigInt, decimals: Int) -> Double? {
        guard decimals >= 0 && number >= 0 else { return nil }
        let (integerPart, fractionalPart) = number.quotientAndRemainder(dividingBy: BigInt(10).power(decimals))
        let integerPartString = "\(integerPart)"
        let fractionalPartInitialString = "\(fractionalPart)"
        let leadingZeroes =
            decimals > 0 ? String(repeating: "0", count: decimals - fractionalPartInitialString.count) : ""
        let fractionalPartFinalString = leadingZeroes + fractionalPartInitialString
        return Double("\(integerPartString).\(fractionalPartFinalString)")
    }

}
