//
//  BTHService.swift
//  CryptoAPI
//
//  Created by Artemy Markovsky on 1/30/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import Foundation

public protocol BTHService {
/**
     Network information
     
     - Parameter completion: Callback which returns an [BTHNetworkResponseModel](BTHNetworkResponseModel) result  or error
*/
    func network(completion: @escaping (Result<BTHNetworkResponseModel, CryptoApiError>) -> Void)
    
/**
     Send raw bth transaction.
     
     - Parameter transaction: transaction hex
     - Parameter completion: Callback which returns an [BTHSendRawResponseModel](BTHSendRawResponseModel) result  or error
*/
    func sendRaw(transaction: String,
                 completion: @escaping (Result<BTHSendRawResponseModel, CryptoApiError>) -> Void)
    
/**
     Decode raw bth transaction hex.
     
     - Parameter transaction: transaction hex
     - Parameter completion: Callback which returns an [BTHDecodeRawResponseModel](BTHDecodeRawResponseModel) result  or error
*/
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<BTHDecodeRawResponseModel, CryptoApiError>) -> Void)
    
/**
     Returns block object by number or hash
     
     - Parameter numberOrHash: number or hash of block
     - Parameter completion: Callback which returns an [BTHBlockResponseModel](BTHBlockResponseModel) result  or error
*/
    func block(numberOrHash: String,
               completion: @escaping (Result<BTHBlockResponseModel, CryptoApiError>) -> Void)
    
/**
     Returns blocks
     
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [BTHBlocksResponseModel](BTHBlocksResponseModel) result  or error
*/
    func blocks(skip: Int, limit: Int,
                completion: @escaping (Result<BTHBlocksResponseModel, CryptoApiError>) -> Void)
    
/**
     Get transaction by hash
     
     - Parameter hash: hash of transaction
     - Parameter completion: Callback which returns an [BTHTransactionByHashResponseModel](BTHTransactionByHashResponseModel) result  or error
*/
    func transactionBy(hash: String,
                       completion: @escaping (Result<BTHTransactionByHashResponseModel, CryptoApiError>) -> Void)
    
/**
     Get transaction history from one address to another
     
     - Parameter blockHeightOrHash: height or hash of block
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter fromAddress: from address
     - Parameter toAddress: to address
     - Parameter completion: Callback which returns an [BTHTransactionsResponseModel](BTHTransactionsResponseModel) result  or error
*/
    func transactions(blockHeightOrHash: String, skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<BTHTransactionsResponseModel, CryptoApiError>) -> Void)
    
/**
     Get outputs list filtered by addresses and status
     
     - Parameter addresses: addresses
     - Parameter status: status
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [[BTHAddressOutputResponseModel]]([BTHAddressOutputResponseModel]) result  or error
*/
    func addressesOutputs(addresses: [String], status: String, skip: Int, limit: Int,
                          completion: @escaping (Result<[BTHAddressOutputResponseModel], CryptoApiError>) -> Void)
    
/**
     Get data about bth addresses, such as balance.
     Field balance include spent, unspent, confirmed, unconfirmed balance.
     
     - Parameter addresses: addresses
     - Parameter completion: Callback which returns an [[BTHAddressOutInfoResponseModel]]([BTHAddressOutInfoResponseModel]) result  or error
*/
    func addressesUxtoInfo(addresses: [String],
                           completion: @escaping (Result<[BTHAddressOutInfoResponseModel], CryptoApiError>) -> Void)
    
/**
     Get BTH addresses history.
     
     - Parameter addresses: addresses
     - Parameter skip: skip
     - Parameter limit: limit
     - Parameter completion: Callback which returns an [BTHAddressOutHistoryResponseModel](BTHAddressOutHistoryResponseModel) result  or error
*/
    func addressesTransactionsHistory(addresses: [String], skip: Int, limit: Int,
                                      completion: @escaping (Result<BTHAddressOutHistoryResponseModel, CryptoApiError>) -> Void)
}
