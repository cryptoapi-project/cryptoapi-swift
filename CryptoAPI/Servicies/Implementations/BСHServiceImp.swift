//
//  BCHServiceImp.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class BCHServiceImp: BCHService {
    let networkAdapter: BCHNetworkAdapter
    
    public init(networkAdapter: BCHNetworkAdapter) {
        self.networkAdapter = networkAdapter
    }
    
    func network(completion: @escaping (Result<BCHNetworkResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.network(completion: completion)
    }
    
    func estimateFee(completion: @escaping (Result<String, CryptoApiError>) -> Void) {
        networkAdapter.estimateFee(completion: completion)
    }
    
    func sendRaw(transaction: String,
                 completion: @escaping (Result<BCHSendRawResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.sendRaw(transaction: transaction, completion: completion)
    }
    
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<BCHDecodeRawResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.decodeRaw(transaction: transaction, completion: completion)
    }
    
    func block(numberOrHash: String,
               completion: @escaping (Result<BCHBlockResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.block(numberOrHash: numberOrHash, completion: completion)
    }
    
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<BCHBlocksResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.blocks(skip: skip, limit: limit, completion: completion)
    }
    
    func transactionBy(hash: String,
                       completion: @escaping (Result<BCHTransactionByHashResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactionBy(hash: hash, completion: completion)
    }
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BCHTransactionsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactions(blockHeightOrHash: blockHeightOrHash, skip: skip, limit: limit,
                                    fromAddress: fromAddress, toAddress: toAddress, completion: completion)
    }
    
    func addressesOutputs(addresses: [String], status: String, skip: Int, limit: Int,
                          completion: @escaping (Result<[BCHAddressOutputResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.addressesOutputs(addresses: addresses, status: status, skip: skip, limit: limit, completion: completion)
    }
    
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[BCHAddressOutInfoResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.addressesUxtoInfo(addresses: addresses, completion: completion)
    }
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BCHAddressOutHistoryResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.addressesTransactionsHistory(addresses: addresses, skip: skip, limit: limit, completion: completion)
    }
}
