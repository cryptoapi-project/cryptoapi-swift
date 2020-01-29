//
//  ETHTokenTransfersResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTokenTransfersResponseModel: Codable {
    public let addresses: [String]
    public let skip: Int
    public let limit: Int
    public let items: [ETHTokenTransferResponseModel]
    public let count: Int
}

public struct ETHTokenTransferResponseModel {
    public let type: String
    public let executeAddress: String
    public let from: String
    public let to: String
    public let value: String
    public let address: String
    public let blockNumber: Int
    public let transactionHash: String
    public let transactionIndex: Int
    public let timestamp: String
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
