//
//  CtyptoAPI.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

public final class CtyptoAPI {
    public static let `default` = CtyptoAPI(settings: Settings())
    let eth: ETHService
    let common: CommonService
    
    public init(settings: Settings) {
        let configuration = settings.sessionConfiguration
        configuration.timeoutIntervalForRequest = settings.timeoutIntervalForRequest
        configuration.timeoutIntervalForResource = settings.timeoutIntervalForResource
        
        let urlSession = URLSession(configuration: configuration)
        let networkAdapter = NetworkAdapterImp(session: urlSession)
        let ethService = ETHServiceImp(networkAdapter: networkAdapter)
        let commonService = CommonServiceImp(networkAdapter: networkAdapter)
        
        eth = ethService
        common = commonService
    }
}
