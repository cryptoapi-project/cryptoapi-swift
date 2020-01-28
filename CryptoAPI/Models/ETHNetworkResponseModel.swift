//
//  ETHNetworkResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHNetworkResponseModel {
    public let lastBlock: Int
    public let countTransactions: String
    public let hashRate: Int
    public let gasPrice: String
    public let difficulty: Int
}

extension ETHNetworkResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case lastBlock = "last_block"
        case countTransactions = "count_transactions"
        case hashRate = "hashrate"
        case gasPrice = "gas_price"
        case difficulty
    }
}
