//
//  BCHService.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public protocol BCHService {
/**
     Network information
     
     - Parameter completion: Callback which returns an [BCHNetworkResponseModel](BCHNetworkResponseModel) result  or error
*/
    func network(completion: @escaping (Result<BCHNetworkResponseModel, CryptoApiError>) -> Void)
    
/**
     Fee per Kb information
     
     - Parameter completion: Callback which returns an [String](String) result  or error
*/
    func feePerKb(completion: @escaping (Result<String, CryptoApiError>) -> Void)
    
/**
     Send raw BCH transaction.
     
     - Parameter transaction: transaction hex
     - Parameter completion: Callback which returns an [BCHSendRawResponseModel](BCHSendRawResponseModel) result  or error
*/
    func sendRaw(transaction: String,
                 completion: @escaping (Result<BCHSendRawResponseModel, CryptoApiError>) -> Void)
    
/**
     Decode raw BCH transaction hex.
     
     - Parameter transaction: transaction hex
     - Parameter completion: Callback which returns an [BCHDecodeRawResponseModel](BCHDecodeRawResponseModel) result  or error
*/
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<BCHDecodeRawResponseModel, CryptoApiError>) -> Void)
    
/**
     Returns block object by number or hash
     
     - Parameter numberOrHash: number or hash of block
     - Parameter completion: Callback which returns an [BCHBlockResponseModel](BCHBlockResponseModel) result  or error
*/
    func block(numberOrHash: String,
               completion: @escaping (Result<BCHBlockResponseModel, CryptoApiError>) -> Void)
    
/**
     Returns blocks
     
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [BCHBlocksResponseModel](BCHBlocksResponseModel) result  or error
*/
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<BCHBlocksResponseModel, CryptoApiError>) -> Void)
    
/**
     Get transaction by hash
     
     - Parameter hash: hash of transaction
     - Parameter completion: Callback which returns an [BCHTransactionByHashResponseModel](BCHTransactionByHashResponseModel) result  or error
*/
    func transactionBy(hash: String,
                       completion: @escaping (Result<BCHTransactionByHashResponseModel, CryptoApiError>) -> Void)
    
/**
     Get transaction history from one address to another
     
     - Parameter blockHeightOrHash: height or hash of block
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter fromAddress: from address
     - Parameter toAddress: to address
     - Parameter completion: Callback which returns an [BCHTransactionsResponseModel](BCHTransactionsResponseModel) result  or error
*/
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BCHTransactionsResponseModel, CryptoApiError>) -> Void)
    
/**
     Get outputs list filtered by addresses and status
     
     - Parameter addresses: addresses
     - Parameter status: status
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [[BCHAddressOutputResponseModel]]([BCHAddressOutputResponseModel]) result  or error
*/
    func addressesOutputs(addresses: [String], status: String, skip: Int?, limit: Int?,
                          completion: @escaping (Result<[BCHAddressOutputResponseModel], CryptoApiError>) -> Void)
    
/**
     Get data about BCH addresses, such as balance.
     Field balance include spent, unspent, confirmed, unconfirmed balance.
     
     - Parameter addresses: addresses
     - Parameter completion: Callback which returns an [[BCHAddressOutInfoResponseModel]]([BCHAddressOutInfoResponseModel]) result  or error
*/
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[BCHAddressOutInfoResponseModel], CryptoApiError>) -> Void)
    
/**
     Get BCH addresses history.
     
     - Parameter addresses: addresses
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [BCHAddressOutHistoryResponseModel](BCHAddressOutHistoryResponseModel) result  or error
*/
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BCHAddressOutHistoryResponseModel, CryptoApiError>) -> Void)
    
    /**
     Set firebase notification by addresses (balance updated, new transaction)
     
     - Parameter addresses: addresses
     - Parameter firebaseToken: firebase token
     - Parameter types: notification types
     - Parameter completion: Callback which returns an [BCHPushNotificationsResponseModel](BCHPushNotificationsResponseModel) result  or error
     */
    
    func subscribePushNotifications(addresses: [String], firebaseToken: String, types: [CryptoNotificationType],
                                    completion: @escaping (Result<BCHPushNotificationsResponseModel, CryptoApiError>) -> Void)
    
    /**
     Remove firebase notification by addresses
     
     - Parameter addresses: addresses
     - Parameter firebaseToken: firebase token
     - Parameter types: notification types
     - Parameter completion: Callback which returns an [BCHPushNotificationsResponseModel](BCHPushNotificationsResponseModel) result  or error
     */
    
    func unsubscribePushNotifications(addresses: [String], firebaseToken: String, types: [CryptoNotificationType],
                                      completion: @escaping (Result<BCHPushNotificationsResponseModel, CryptoApiError>) -> Void)
}
