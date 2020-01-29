//
//  BTCService.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public protocol BTCService {
    /**
        Network information

        - Parameter completion: Callback which returns an [BTCNetworkResponseModel](BTCNetworkResponseModel) result  or error
    */
        func network(completion: @escaping (Result<BTCNetworkResponseModel, CryptoApiError>) -> Void)
        
}
