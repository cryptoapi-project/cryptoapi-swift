//
//  BTCNetworkResponseModel.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct BTCNetworkResponseModel {
    public let lastBlock: String
    public let countTransactions: String
    public let hashRate: String
    public let difficulty: String
}

extension BTCNetworkResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case lastBlock = "last_block"
        case countTransactions = "count_transactions"
        case hashRate = "hashrate"
        case difficulty
    }
}
