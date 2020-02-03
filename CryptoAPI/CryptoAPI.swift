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
    public let bth: BTHService
    public let btc: BTCService
    public let common: CommonService
    
    public init(settings: Settings) {
        let configuration = settings.sessionConfiguration
        configuration.timeoutIntervalForRequest = settings.timeoutIntervalForRequest
        configuration.timeoutIntervalForResource = settings.timeoutIntervalForResource
        
        let urlSession = URLSession(configuration: configuration)
        let authorizationToken = settings.authorizationToken
        
        let ethNetworkAdapter = ETHNetworkAdapterImp(session: urlSession, authToken: authorizationToken, needLogs: settings.needLogs)
        let btcNetworkAdapter = BTCNetworkAdapterImp(session: urlSession, authToken: authorizationToken, needLogs: settings.needLogs)
        let bthNetworkAdapter = BTHNetworkAdapterImp(session: urlSession, authToken: authorizationToken, needLogs: settings.needLogs)
        let commonNetworkAdapter = CommonNetworkAdapterImp(session: urlSession, authToken: authorizationToken, needLogs: settings.needLogs)
        
        let ethService = ETHServiceImp(networkAdapter: ethNetworkAdapter)
        let btcService = BTCServiceImp(networkAdapter: btcNetworkAdapter)
        let bthService = BTHServiceImp(networkAdapter: bthNetworkAdapter)
        let commonService = CommonServiceImp(networkAdapter: commonNetworkAdapter)
        
        bth = bthService
        eth = ethService
        btc = btcService
        common = commonService
    }
}
