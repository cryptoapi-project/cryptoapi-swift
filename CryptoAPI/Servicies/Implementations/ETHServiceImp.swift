//
//  ETHServiceImp.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

final class ETHServiceImp: ETHService {
    let networkAdapter: NetworkAdapter
    
    public init(networkAdapter: NetworkAdapter) {
        self.networkAdapter = networkAdapter
    }
    
    func balance(addresses: [String], completion: @escaping (Result<[ETHBalanceResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.balance(addresses: addresses, completion: completion)
    }
    
    func estimateGas(fromAddress: String, toAddress: String, data: String, value: String,
                     completion: @escaping (Result<ETHEstimateGasResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.estimateGas(fromAddress: fromAddress, toAddress: toAddress, data: data, value: value, completion: completion)
    }
    
    func network(completion: @escaping (Result<ETHNetworkResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.network(completion: completion)
    }
    
    func info(addresses: [String], completion: @escaping (Result<[ETHInfoResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.info(addresses: addresses, completion: completion)
    }
    
    func transfers(skip: Int, limit: Int, addresses: [String], positive: String,
                   completion: @escaping (Result<ETHTransfersResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transfers(skip: skip, limit: limit,
                                 addresses: addresses, positive: positive, completion: completion)
    }
    
    func externalTransfers(skip: Int, limit: Int, addresses: [String],
                           completion: @escaping (Result<ETHExternalTransfersResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.externalTransfers(skip: skip, limit: limit,
                                 addresses: addresses, completion: completion)
    }
    
    func transactions(skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<ETHTransactionsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactions(skip: skip, limit: limit, fromAddress: fromAddress,
                                    toAddress: toAddress, completion: completion)
    }
    
    func transaction(hash: String,
                     completion: @escaping (Result<ETHTransactionResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transaction(hash: hash, completion: completion)
    }
    
    func contractInfo(addresses: [String],
                      completion: @escaping (Result<ETHContractInfoResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.contractInfo(addresses: addresses, completion: completion)
    }
    
    func tokensBalance(addresses: [String], skip: Int, limit: Int,
                       completion: @escaping (Result<ETHTokensBalanceResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.tokensBalance(addresses: addresses, skip: skip, limit: limit, completion: completion)
    }
    
    func tokenTransfers(tokenAddress: String, addresses: [String], skip: Int, limit: Int,
                        completion: @escaping (Result<ETHTokenTransfersResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.tokenTransfers(tokenAddress: tokenAddress, addresses: addresses,
                                      skip: skip, limit: limit, completion: completion)
    }
    
    func tokenInfo(addresses: [String],
                   completion: @escaping (Result<ETHTokenInfoResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.tokenInfo(addresses: addresses, completion: completion)
    }
    
    func tokenSearch(query: String, skip: Int, limit: Int, types: [String],
                     completion: @escaping (Result<ETHTokensQueryResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.tokenSearch(query: query, skip: skip, limit: limit, types: types, completion: completion)
    }
}
