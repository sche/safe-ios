//
//  Copyright © 2018 Gnosis Ltd. All rights reserved.
//

import Foundation
import EthereumDomainModel
import Common

public class SecureExternallyOwnedAccountRepository: ExternallyOwnedAccountRepository {

    private let store: SecureStore

    public init (store: SecureStore) {
        self.store = store
    }

    public func save(_ account: ExternallyOwnedAccount) throws {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        let data = try encoder.encode(account.dataStruct)
        try store.save(data: data, forKey: account.address.value)
    }

    public func remove(address: Address) throws {
        try store.removeData(forKey: address.value)
    }

    public func find(by address: Address) throws -> ExternallyOwnedAccount? {
        guard let data = try store.data(forKey: address.value) else { return nil }
        let decoder = PropertyListDecoder()
        let dataStruct = try decoder.decode(ExternallyOwnedAccountData.self, from: data)
        return ExternallyOwnedAccount(dataStruct: dataStruct)
    }

}

fileprivate struct ExternallyOwnedAccountData: Codable {

    var address: String
    var mnemonic: [String]
    var privateKey: Data
    var publicKey: Data

}

fileprivate extension ExternallyOwnedAccount {

    var dataStruct: ExternallyOwnedAccountData {
        return ExternallyOwnedAccountData(address: address.value,
                                          mnemonic: mnemonic.words,
                                          privateKey: privateKey.data,
                                          publicKey: publicKey.data)
    }

    convenience init(dataStruct: ExternallyOwnedAccountData) {
        self.init(address: Address(value: dataStruct.address),
                  mnemonic: Mnemonic(words: dataStruct.mnemonic),
                  privateKey: PrivateKey(data: dataStruct.privateKey),
                  publicKey: PublicKey(data: dataStruct.publicKey))
    }

}
