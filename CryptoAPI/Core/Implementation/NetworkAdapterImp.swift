//
//  NetworkAdapterImp.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation

final class NetworkAdapterImp: NetworkAdapter {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func balance(address: String,
                 completion: @escaping (Result<[ETHBalanceResponseModel], CryptoApiError>) -> Void) {
        ETHNetwork.balance(address: address)
            .request(type: [ETHBalanceResponseModel].self, session: session, completionHandler: completion)
    }
    
    func estimateGas(fromAddress: String, toAddress: String, data: String, value: String,
                     completion: @escaping (Result<ETHEstimateGasResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.estimateGas(from: fromAddress, to: toAddress, value: value, data: data)
            .request(type: ETHEstimateGasResponseModel.self, completionHandler: completion)
    }
    
    func network(completion: @escaping (Result<ETHNetworkResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.network
            .request(type: ETHNetworkResponseModel.self, completionHandler: completion)
    }
    
    func info(address: String, completion: @escaping (Result<[ETHInfoResponseModel], CryptoApiError>) -> Void) {
        ETHNetwork.info(address: address)
            .request(type: [ETHInfoResponseModel].self, completionHandler: completion)
    }
    
    func transfers(skip: Int, limit: Int, addresses: String, positive: String,
                   completion: @escaping (Result<ETHTransfersResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.history(address: addresses, from: skip, limit: limit)
            .request(type: ETHTransfersResponseModel.self, completionHandler: completion)
    }
    
    func externalTransfers(skip: Int, limit: Int, addresses: String,
                           completion: @escaping (Result<ETHExternalTransfersResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.externalHistory(address: addresses, from: skip, limit: limit)
            .request(type: ETHExternalTransfersResponseModel.self, completionHandler: completion)
    }
    
    func transactions(skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<ETHTransactionsResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.transactions(fromAddress: fromAddress, toAddress: toAddress, skip: skip, limit: limit)
            .request(type: ETHTransactionsResponseModel.self, completionHandler: completion)
    }
}
