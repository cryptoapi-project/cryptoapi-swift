//
//  ETHTransfersResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHTransfersResponseModel: Codable {
    let addresses: [String]
    let skip: Int
    let limit: Int
    let items: [ETHTransferResponseModel]
    let count: Int
}

public struct ETHTransferResponseModel {
    let blockNumber: Int
    let utc: String
    let from: String
    let gas: Int
    let hash: String
    let to: String
    let value: String
    let gasPrice: String
    let isInternal: Bool
}

extension ETHTransferResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case blockNumber = "block_number"
        case utc
        case from
        case gas
        case hash
        case to
        case value
        case gasPrice = "gas_price"
        case isInternal = "internal"
    }
}
