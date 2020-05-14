//
//  LTCPushNotificationsResponseModel.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 5/14/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

public struct LTCPushNotificationsResponseModel: Codable {
    public let addresses: [String]
    public let token: String?
}
