//
//  CommonService.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public protocol CommonService {
/**
    Get coins rates
    - Parameter completion: Callback which returns an [CmnRatesResponseModel](CmnRatesResponseModel) result  or error
*/
    func rates(completion: @escaping (Result<CmnRatesResponseModel, CryptoApiError>) -> Void)
    
/**
    Get coin rates history
    - Parameter coin: Type of coin
    - Parameter completion: Callback which returns an [CmnRatesHistoryResponseModel](CmnRatesHistoryResponseModel) result  or error
*/
    func ratesHistory(coin: String, completion: @escaping (Result<[CmnRatesHistoryResponseModel], CryptoApiError>) -> Void)
    
/**
    Get Coins
    - Parameter completion: Callback which returns an [[String]]([String]) result  or error
*/
    func coins(completion: @escaping (Result<[String], CryptoApiError>) -> Void)
}
