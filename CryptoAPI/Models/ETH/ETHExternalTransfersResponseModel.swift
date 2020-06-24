//
//  ETHExternalTransfersResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHExternalTransfersResponseModel: Codable {
    public let addresses: [String]
    public let skip: Int
    public let limit: Int
    public let items: [ETHExternalTransferResponseModel]
    public let count: Int
}

public struct ETHExternalTransferResponseModel {
    public let blockHash: String?
    public let blockNumber: Int?
    public let utc: String
    public let from: String
    public let gas: Int
    public let gasPrice: String
    public let hash: String
    public let input: String
    public let nonce: Int
    public let to: String?
    public let value: String
    public let transactionIndex: Int?
    public let v: String
    public let s: String
    public let r: String
    public let internalTransactions: [ETHInternalTransaction]
}

extension ETHExternalTransferResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case blockHash = "block_hash"
        case blockNumber = "block_number"
        case utc
        case from
        case gasPrice = "gas_price"
        case gas
        case hash
        case input
        case nonce
        case transactionIndex = "transaction_index"
        case to
        case value
        case v
        case s
        case r
        case internalTransactions = "internal_transactions"
    }
}
