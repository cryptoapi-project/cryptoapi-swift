//
//  LTCNetworkResponseModel.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 5/14/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct LTCNetworkResponseModel {
    public let lastBlock: String
    public let countTransactions: String
    public let hashRate: String
    public let difficulty: String
    public let estimateFee: String
}

extension LTCNetworkResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case lastBlock = "last_block"
        case countTransactions = "count_transactions"
        case hashRate = "hashrate"
        case difficulty
        case estimateFee = "estimate_fee"
    }
}
