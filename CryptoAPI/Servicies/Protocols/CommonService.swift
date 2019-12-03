//
//  CommonService.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public protocol CommonService {
/**
    Get Coins
    - Parameter completion: Callback which returns an [[String]]([String]) result  or error
*/
    func coins(completion: @escaping (Result<[String], CryptoApiError>) -> Void)
}
