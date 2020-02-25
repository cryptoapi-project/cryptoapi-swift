//
//  BTCServiceImp.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/29/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class BTCServiceImp: BTCService {
    let networkAdapter: BTCNetworkAdapter
    
    public init(networkAdapter: BTCNetworkAdapter) {
        self.networkAdapter = networkAdapter
    }
    
    func network(completion: @escaping (Result<BTCNetworkResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.network(completion: completion)
    }
    
    func estimateFee(completion: @escaping (Result<String, CryptoApiError>) -> Void) {
        networkAdapter.estimateFee(completion: completion)
    }
    
    func sendRaw(transaction: String,
                 completion: @escaping (Result<BTCSendRawResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.sendRaw(transaction: transaction, completion: completion)
    }
    
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<BTCDecodeRawResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.decodeRaw(transaction: transaction, completion: completion)
    }
    
    func block(numberOrHash: String,
               completion: @escaping (Result<BTCBlockResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.block(numberOrHash: numberOrHash, completion: completion)
    }
    
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<BTCBlocksResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.blocks(skip: skip, limit: limit, completion: completion)
    }
    
    func transactionBy(hash: String,
                       completion: @escaping (Result<BTCTransactionByHashResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactionBy(hash: hash, completion: completion)
    }
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BTCTransactionsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactions(blockHeightOrHash: blockHeightOrHash, skip: skip, limit: limit,
                                    fromAddress: fromAddress, toAddress: toAddress, completion: completion)
    }
    
    func addressesOutputs(addresses: [String], status: String, skip: Int?, limit: Int?,
                          completion: @escaping (Result<[BTCAddressOutputResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.addressesOutputs(addresses: addresses, status: status, skip: skip, limit: limit, completion: completion)
    }
    
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[BTCAddressOutInfoResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.addressesUxtoInfo(addresses: addresses, completion: completion)
    }
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BTCAddressOutHistoryResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.addressesTransactionsHistory(addresses: addresses, skip: skip, limit: limit, completion: completion)
    }
}
