//
//  LTCServiceImp.swift
//  CryptoAPI
//
//  Created by Alexander Eskin on 5/14/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

final class LTCServiceImp: LTCService {
    let networkAdapter: LTCNetworkAdapter
    
    public init(networkAdapter: LTCNetworkAdapter) {
        self.networkAdapter = networkAdapter
    }
    
    func network(completion: @escaping (Result<LTCNetworkResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.network(completion: completion)
    }
    
    func feePerKb(completion: @escaping (Result<String, CryptoApiError>) -> Void) {
        networkAdapter.feePerKb(completion: completion)
    }
    
    func sendRaw(transaction: String,
                 completion: @escaping (Result<LTCSendRawResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.sendRaw(transaction: transaction, completion: completion)
    }
    
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<LTCDecodeRawResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.decodeRaw(transaction: transaction, completion: completion)
    }
    
    func block(numberOrHash: String,
               completion: @escaping (Result<LTCBlockResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.block(numberOrHash: numberOrHash, completion: completion)
    }
    
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<LTCBlocksResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.blocks(skip: skip, limit: limit, completion: completion)
    }
    
    func transactionBy(hash: String,
                       completion: @escaping (Result<LTCTransactionByHashResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactionBy(hash: hash, completion: completion)
    }
    
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<LTCTransactionsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.transactions(blockHeightOrHash: blockHeightOrHash, skip: skip, limit: limit,
                                    fromAddress: fromAddress, toAddress: toAddress, completion: completion)
    }
    
    func addressesOutputs(addresses: [String], status: String, skip: Int?, limit: Int?,
                          completion: @escaping (Result<[LTCAddressOutputResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.addressesOutputs(addresses: addresses, status: status, skip: skip, limit: limit, completion: completion)
    }
    
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[LTCAddressOutInfoResponseModel], CryptoApiError>) -> Void) {
        networkAdapter.addressesUxtoInfo(addresses: addresses, completion: completion)
    }
    
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<LTCAddressOutHistoryResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.addressesTransactionsHistory(addresses: addresses, skip: skip, limit: limit, completion: completion)
    }
    
    func subscribePushNotifications(addresses: [String], firebaseToken: String, types: String,
                                    completion: @escaping (Result<LTCPushNotificationsResponseModel, CryptoApiError>) -> Void) {
        networkAdapter.subscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken, types: types, completion: completion)
    }
    
    func unsubscribePushNotifications(addresses: [String], firebaseToken: String, types: String,
                                      completion: @escaping (Result<Bool, CryptoApiError>) -> Void) {
        networkAdapter.unsubscribePushNotifications(addresses: addresses, firebaseToken: firebaseToken, types: types, completion: completion)
    }
}
