//
//  BCHAddressOutHistoryResponseModel.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct BCHAddressOutHistoryResponseModel: Codable {
    public let skip: Int
    public let limit: Int
    public let count: Int
    public let items: [BCHTransactionByHashResponseModel]
}
