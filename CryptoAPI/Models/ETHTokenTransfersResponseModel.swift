//
//  ETHTokenTransfersResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTokenTransfersResponseModel: Codable {
    let addresses: [String]
    let skip: Int
    let limit: Int
    let items: [ETHTransferResponseModel]
    let count: Int
}

public struct ETHTokenTransferResponseModel {
    let type: String
    let executeAddress: String
    let from: String
    let to: String
    let value: String
    let address: String
    let blockNumber: Int
    let transactionHash: String
    let transactionIndex: Int
    let timestamp: String
}

extension ETHTokenTransferResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case executeAddress = "execute_address"
        case from
        case to
        case value
        case address
        case blockNumber = "block_number"
        case transactionHash = "transaction_hash"
        case transactionIndex = "transaction_index"
        case timestamp
    }
}
