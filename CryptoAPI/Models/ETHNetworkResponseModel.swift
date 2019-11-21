//
//  ETHNetworkResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHNetworkResponseModel: Codable {
    public let lastBlock: Int
    public let countTransactions: String
    public let hashRate: Int
    public let gasPrice: Int
    public let difficulty: Int
}
