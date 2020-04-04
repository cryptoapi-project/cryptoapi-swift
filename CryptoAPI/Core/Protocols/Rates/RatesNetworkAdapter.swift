//
//  RatesNetworkAdapter.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 4/3/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

protocol RatesNetworkAdapter {
    func rates(coins: [String], completion: @escaping (Result<[RatesResponseModel], CryptoApiError>) -> Void)
    func ratesHistory(coins: [String], completion: @escaping (Result<[RatesHistoryResponseModel], CryptoApiError>) -> Void)
}
