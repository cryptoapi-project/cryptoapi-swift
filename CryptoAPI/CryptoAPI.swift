//
//  CryptoAPI.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

public final class CryptoAPI {
    public let eth: ETHService
    public let common: CommonService
    
    public init(settings: Settings) {
        let configuration = settings.sessionConfiguration
        configuration.timeoutIntervalForRequest = settings.timeoutIntervalForRequest
        configuration.timeoutIntervalForResource = settings.timeoutIntervalForResource
        
        let urlSession = URLSession(configuration: configuration)
        let authorizationToken = settings.authorizationToken
        let ethNetworkAdapter = ETHNetworkAdapterImp(session: urlSession, authToken: authorizationToken)
        let commonNetworkAdapter = CommonNetworkAdapterImp(session: urlSession, authToken: authorizationToken)
        let ethService = ETHServiceImp(networkAdapter: ethNetworkAdapter)
        let commonService = CommonServiceImp(networkAdapter: commonNetworkAdapter)
        
        eth = ethService
        common = commonService
    }
}
