//
//  BTCAddressOutInfoModel.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct BTCAddressOutInfoResponseModel: Codable {
    public let address: String
    public let balance: BTCAddressBalanceResponseModel
}

public struct BTCAddressBalanceResponseModel: Codable {
    public let spent: String
    public let unspent: String
    public let confirmed: String
    public let uncorfirmed: String
}
