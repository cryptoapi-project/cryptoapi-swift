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
    
    func balance(addresses: [String],
                 completion: @escaping (Result<[ETHBalanceResponseModel], CryptoApiError>) -> Void) {
        ETHNetwork.balance(addresses: addresses)
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
    
    func info(addresses: [String], completion: @escaping (Result<[ETHInfoResponseModel], CryptoApiError>) -> Void) {
        ETHNetwork.info(addresses: addresses)
            .request(type: [ETHInfoResponseModel].self, completionHandler: completion)
    }
    
    func transfers(skip: Int, limit: Int, addresses: [String], positive: String,
                   completion: @escaping (Result<ETHTransfersResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.history(addresses: addresses, from: skip, limit: limit)
            .request(type: ETHTransfersResponseModel.self, completionHandler: completion)
    }
    
    func externalTransfers(skip: Int, limit: Int, addresses: [String],
                           completion: @escaping (Result<ETHExternalTransfersResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.externalHistory(addresses: addresses, from: skip, limit: limit)
            .request(type: ETHExternalTransfersResponseModel.self, completionHandler: completion)
    }
    
    func transactions(skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<ETHTransactionsResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.transactions(fromAddress: fromAddress, toAddress: toAddress, skip: skip, limit: limit)
            .request(type: ETHTransactionsResponseModel.self, completionHandler: completion)
    }
    
    func transaction(hash: String,
                     completion: @escaping (Result<ETHTransactionResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.transaction(hash: hash)
            .request(type: ETHTransactionResponseModel.self, completionHandler: completion)
    }
    
    func contractInfo(address: String,
                      completion: @escaping (Result<ETHContractInfoResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.contractInfo(address: address)
            .request(type: ETHContractInfoResponseModel.self, completionHandler: completion)
    }
    
    func tokensBalance(address: String, skip: Int, limit: Int,
                       completion: @escaping (Result<ETHTokensBalanceResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.tokenBalance(address: address, skip: skip, limit: limit)
            .request(type: ETHTokensBalanceResponseModel.self, completionHandler: completion)
    }
    
    func tokenTransfers(tokenAddress: String, addresses: [String], skip: Int, limit: Int,
                        completion: @escaping (Result<ETHTokenTransfersResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.tokenHistory(tokenAddress: tokenAddress, addresses: addresses, from: skip, limit: limit)
            .request(type: ETHTokenTransfersResponseModel.self, completionHandler: completion)
    }
    
    func tokenInfo(address: String,
                   completion: @escaping (Result<ETHTokenInfoResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.tokenInfo(address: address)
            .request(type: ETHTokenInfoResponseModel.self, completionHandler: completion)
    }
    
    func tokenSearch(query: String, skip: Int, limit: Int, types: [String],
                     completion: @escaping (Result<ETHTokensQueryResponseModel, CryptoApiError>) -> Void) {
        ETHNetwork.queryTokens(query: query, skip: skip, limit: limit, types: types)
            .request(type: ETHTokensQueryResponseModel.self, completionHandler: completion)
    }
}
    
