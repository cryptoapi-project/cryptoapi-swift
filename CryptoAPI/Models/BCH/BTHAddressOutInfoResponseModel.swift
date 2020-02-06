//
//  BCHAddressOutInfoModel.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct BCHAddressOutInfoResponseModel: Codable {
    public let address: String
    public let balance: BCHAddressBalanceResponseModel
}

public struct BCHAddressBalanceResponseModel: Codable {
    public let spent: String
    public let unspent: String
    public let confirmed: String
    public let unconfirmed: String
}
