//
//  LTCTransactionsResponseModel.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 5/14/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct LTCTransactionsResponseModel {
    public let blockHeightOfHash: Int
    public let skip: Int
    public let limit: Int
    public let fromAddress: String?
    public let toAddress: String?
    public let items: [LTCTransactionByHashResponseModel]
}

extension LTCTransactionsResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case blockHeightOfHash = "block_height_or_hash"
        case skip
        case limit
        case fromAddress = "from"
        case toAddress = "to"
        case items
    }
}
