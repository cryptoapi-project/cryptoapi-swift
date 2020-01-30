//
//  BTHServiceImp.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class BTHServiceImp: BTHService {
    let networkAdapter: BTHNetworkAdapter
    
    public init(networkAdapter: BTHNetworkAdapter) {
        self.networkAdapter = networkAdapter
    }
    
    func network(completion: @escaping (Result<BTHNetworkResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.network(completion: completion)
    }
    
    func sendRaw(transaction: String,
                 completion: @escaping (Result<BTHSendRawResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.sendRaw(transaction: transaction, completion: completion)
    }
    
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<BTHDecodeRawResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.decodeRaw(transaction: transaction, completion: completion)
    }
    
    func block(numberOrHash: String,
               completion: @escaping (Result<BTHBlockResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.block(numberOrHash: numberOrHash, completion: completion)
    }
    
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<BTHBlocksResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.blocks(skip: skip, limit: limit, completion: completion)
    }
    
    func transactionBy(hash: String,
                       completion: @escaping (Result<BTHTransactionByHashResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactionBy(hash: hash, completion: completion)
    }
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BTHTransactionsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactions(blockHeightOrHash: blockHeightOrHash, skip: skip, limit: limit,
                                    fromAddress: fromAddress, toAddress: toAddress, completion: completion)
    }
    
    func addressesOutputs(addresses: [String], status: String, skip: Int, limit: Int,
                          completion: @escaping (Result<[BTHAddressOutputResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.addressesOutputs(addresses: addresses, status: status, skip: skip, limit: limit, completion: completion)
    }
    
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[BTHAddressOutInfoResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.addressesUxtoInfo(addresses: addresses, completion: completion)
    }
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BTHAddressOutHistoryResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.addressesTransactionsHistory(addresses: addresses, skip: skip, limit: limit, completion: completion)
    }
}
