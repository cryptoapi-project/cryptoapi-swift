//
//  ETHExternalTransfersResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHExternalTransfersResponseModel: Codable {
    let addresses: [String]
    let skip: Int
    let limit: Int
    let items: [ETHExternalTransferResponseModel]
    let count: Int
}

public struct ETHExternalTransferResponseModel {
    let blockHash: String
    let blockNumber: Int
    let utc: String
    let from: String
    let gas: Int
    let gasPrice: String
    let hash: String
    let input: String
    let nonce: Int
    let to: String
    let value: String
    let transactionIndex: Int
    let v: String
    let s: String
    let r: String
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
    }
}
