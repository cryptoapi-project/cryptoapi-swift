//
//  ComonNetworkAdapter.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/19/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

protocol CommonNetworkAdapter {
    func rates(completion: @escaping (Result<CmnRatesResponseModel, CryptoApiError>) -> Void)
    func ratesHistory(coin: String, completion: @escaping (Result<[CmnRatesHistoryResponseModel], CryptoApiError>) -> Void)
    func coins(completion: @escaping (Result<[String], CryptoApiError>) -> Void)
}
