//
//  BTCPushNotificationsResponseModel.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 4/4/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public struct BTCPushNotificationsResponseModel: Codable {
    public let addresses: [String]
    public let token: String
    public let types: [CryptoNotificationType]
}
