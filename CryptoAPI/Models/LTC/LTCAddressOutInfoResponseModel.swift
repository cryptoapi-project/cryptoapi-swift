//
//  LTCAddressOutInfoResponseModel.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 5/14/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct LTCAddressOutInfoResponseModel: Codable {
    public let address: String
    public let balance: LTCAddressBalanceResponseModel
}

public struct LTCAddressBalanceResponseModel: Codable {
    public let spent: String
    public let unspent: String
    public let confirmed: String
    public let unconfirmed: String
}
