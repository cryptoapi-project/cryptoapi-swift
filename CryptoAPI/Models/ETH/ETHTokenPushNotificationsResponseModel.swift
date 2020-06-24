//
//  ETHTokenPushNotificationsResponseModel.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 6/24/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public struct ETHTokenPushNotificationsResponseModel: Codable {
    public let addresses: [String]
    public let tokenAddress: String
    public let token: String
    public let types: [CryptoNotificationType]
    
    enum CodingKeys: String, CodingKey {
        case addresses
        case tokenAddress = "token_address"
        case token
        case types
    }
}
