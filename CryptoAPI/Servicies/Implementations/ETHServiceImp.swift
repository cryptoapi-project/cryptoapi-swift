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
    
    func balance(address: String, completion: @escaping (Result<[ETHBalanceResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.balance(address: address, completion: completion)
    }
    
    func estimateGas(fromAddress: String, toAddress: String, data: String, value: String,
                     completion: @escaping (Result<ETHEstimateGasResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.estimateGas(fromAddress: fromAddress, toAddress: toAddress, data: data, value: value, completion: completion)
    }
    
    func network(completion: @escaping (Result<ETHNetworkResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.network(completion: completion)
    }
    
    func info(address: String, completion: @escaping (Result<[ETHInfoResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.info(address: address, completion: completion)
    }
    
    func transfers(skip: Int, limit: Int, addresses: String, positive: String,
                   completion: @escaping (Result<ETHTransfersResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transfers(skip: skip, limit: limit,
                                 addresses: addresses, positive: positive, completion: completion)
    }
    
    func externalTransfers(skip: Int, limit: Int, addresses: String,
                           completion: @escaping (Result<ETHExternalTransfersResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.externalTransfers(skip: skip, limit: limit,
                                 addresses: addresses, completion: completion)
    }
}
