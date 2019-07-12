//
//  Copyright © 2019 Gnosis Ltd. All rights reserved.
//

import Foundation
import Common

public struct WCURL: Codable {

    public let topic: String
    public let version: String
    public let bridgeURL: URL
    public let key: String

    public init(topic: String, version: String, bridgeURL: URL, key: String) {
        self.topic = topic
        self.version = version
        self.bridgeURL = bridgeURL
        self.key = key
    }

    public init?(data: Data) {
        guard let url = try? JSONDecoder().decode(WCURL.self, from: data) else { return nil }
        self = url
    }

    public var data: Data {
        return try! JSONEncoder().encode(self)
    }

}

public struct WCClientMeta: Codable {

    public let name: String
    public let description: String
    public let icons: [URL]
    public let url: URL

    public init(name: String, description: String, icons: [URL], url: URL) {
        self.name = name
        self.description = description
        self.icons = icons
        self.url = url
    }

}

public struct WCDAppInfo: Codable {

    public let peerId: String
    public let peerMeta: WCClientMeta

    public init(peerId: String, peerMeta: WCClientMeta) {
        self.peerId = peerId
        self.peerMeta = peerMeta
    }

    public init?(data: Data) {
        guard let info = try? JSONDecoder().decode(WCDAppInfo.self, from: data) else { return nil }
        self = info
    }

    public var data: Data {
        return try! JSONEncoder().encode(self)
    }

}

public struct WCWalletInfo: Codable {

    public let approved: Bool
    public let accounts: [String]
    public let chainId: Int
    public let peerId: String
    public let peerMeta: WCClientMeta

    public init(approved: Bool, accounts: [String], chainId: Int, peerId: String, peerMeta: WCClientMeta) {
        self.approved = approved
        self.accounts = accounts
        self.chainId = chainId
        self.peerId = peerId
        self.peerMeta = peerMeta
    }

    public init?(data: Data) {
        guard let info = try? JSONDecoder().decode(WCWalletInfo.self, from: data) else { return nil }
        self = info
    }

    public var data: Data {
        return try! JSONEncoder().encode(self)
    }

}

public enum WCSessionStatus: String, Codable {

    case connecting
    case connected
    case disconnected

}

public class WCSessionID: BaseID {}

public class WCSession: IdentifiableEntity<WCSessionID> {

    public let url: WCURL
    public let dAppInfo: WCDAppInfo
    public let walletInfo: WCWalletInfo?
    public let status: WCSessionStatus

    public init(url: WCURL, dAppInfo: WCDAppInfo, walletInfo: WCWalletInfo?, status: WCSessionStatus) {
        self.url = url
        self.dAppInfo = dAppInfo
        self.walletInfo = walletInfo
        self.status = status
        super.init(id: WCSessionID(String(dAppInfo.peerId)))
    }

}
