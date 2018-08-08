//
//  Copyright © 2018 Gnosis Ltd. All rights reserved.
//

import Foundation
import IdentityAccessDomainModel
import CommonCrypto

public final class EthereumKitEncryptionService: EncryptionService {

    public init() {}

    public func encrypted(_ plainText: String) -> String {
        guard let data = plainText.data(using: .utf8) else { return plainText }
        var hashBuffer = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = data.withUnsafeBytes {
            CC_SHA256($0, CC_LONG(data.count), &hashBuffer)
        }
        let hash = Data(bytes: hashBuffer)
        return hash.base64EncodedString()
    }

}
