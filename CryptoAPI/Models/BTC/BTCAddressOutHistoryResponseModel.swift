//
//  BTCAddressOutHistoryResponseModel.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct BTCAddressOutHistoryResponseModel: Codable {
    let skip: Int
    let limit: Int
    let count: Int
    let items: [BTCTransactionByHashResponseModel]
}
