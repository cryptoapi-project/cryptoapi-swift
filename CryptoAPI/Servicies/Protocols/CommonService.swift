//
//  CommonService.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public protocol CommonService {
    func rates(completion: @escaping (Result<CmnRatesResponseModel, CryptoApiError>) -> Void)
    func ratesHistory(coin: String, completion: @escaping (Result<[CmnRatesHistoryResponseModel], CryptoApiError>) -> Void)
    func coins(completion: @escaping (Result<[String], CryptoApiError>) -> Void)
}
