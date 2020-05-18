//
//  RatesServiceImp.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 4/3/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class RatesServiceImp: RatesService {
    let networkAdapter: RatesNetworkAdapter
    
    public init(networkAdapter: RatesNetworkAdapter) {
        self.networkAdapter = networkAdapter
    }
    
    func rates(coins: [String], completion: @escaping (Result<[RatesResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.rates(coins: coins, completion: completion)
    }
    
    func ratesHistory(coins: [String], completion: @escaping (Result<[RatesHistoryResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.ratesHistory(coins: coins, completion: completion)
    }
}
