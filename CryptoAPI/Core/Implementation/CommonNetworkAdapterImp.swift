//
//  CommonNetworkAdapterImp.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/19/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

final class CommonNetworkAdapterImp: CommonNetworkAdapter {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func rates(completion: @escaping (Result<CmnRatesResponseModel, CryptoApiError>) -> Void) {
        CommonNetwork.rates
            .request(type: CmnRatesResponseModel.self, completionHandler: completion)
    }
    
    func ratesHistory(coin: String, completion: @escaping (Result<[CmnRatesHistoryResponseModel], CryptoApiError>) -> Void) {
        CommonNetwork.rateHistory(coin: coin)
            .request(type: [CmnRatesHistoryResponseModel].self, completionHandler: completion)
    }
    
    func coins(completion: @escaping (Result<[String], CryptoApiError>) -> Void) {
        CommonNetwork.coins
            .request(type: [String].self, completionHandler: completion)
    }
}
