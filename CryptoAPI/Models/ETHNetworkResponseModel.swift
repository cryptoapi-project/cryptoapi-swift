//
//  ETHNetworkResponseModel.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/18/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public struct ETHNetworkResponseModel: Codable {
    let lastBlock: Int
    let countTransactions: String
    let hashRate: Int
    let gasPrice: Int
    let difficulty: Int
}
