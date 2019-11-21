//
//  ETHService.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public protocol ETHService {
/**
    Return addresses balance
    
    - Parameter addresses: Addresses
    - Parameter completion: Callback which returns an [[ETHBalanceResponseModel]]([ETHBalanceResponseModel]) result  or error
*/
    func balance(addresses: [String],
                 completion: @escaping (Result<[ETHBalanceResponseModel], CryptoApiError>) -> Void)
    
/**
    Estimate Gas
    
    - Parameter fromAddress: from address
    - Parameter toAddress: to address
    - Parameter data: data
    - Parameter value: value
    - Parameter completion: Callback which returns an [ETHEstimateGasResponseModel](ETHEstimateGasResponseModel) result  or error
*/
    func estimateGas(fromAddress: String, toAddress: String, data: String, value: String,
                     completion: @escaping (Result<ETHEstimateGasResponseModel, CryptoApiError>) -> Void)
    
/**
    Network information

    - Parameter completion: Callback which returns an [ETHNetworkResponseModel](ETHNetworkResponseModel) result  or error
*/
    func network(completion: @escaping (Result<ETHNetworkResponseModel, CryptoApiError>) -> Void)
    
/**
    Return balance, type, count transaction by addresses.

    - Parameter addresses: Addresses
    - Parameter completion: Callback which returns an [ETHNetworkResponseModel](ETHNetworkResponseModel) result  or error
*/
    func info(addresses: [String],
              completion: @escaping (Result<[ETHInfoResponseModel], CryptoApiError>) -> Void)
    
/**
    Get addresses transactions

    - Parameter skip: skip
    - Parameter limit: limit
    - Parameter addresses: addresses
    - Parameter positive: positive
    - Parameter completion: Callback which returns an [ETHTransfersResponseModel](ETHTransfersResponseModel) result  or error
*/
    func transfers(skip: Int, limit: Int, addresses: [String], positive: String,
                   completion: @escaping (Result<ETHTransfersResponseModel, CryptoApiError>) -> Void)
    
/**
    Get an interception of addresses in external transactions

    - Parameter skip: skip
    - Parameter limit: limit
    - Parameter addresses: addresses
    - Parameter completion: Callback which returns an [ETHExternalTransfersResponseModel](ETHExternalTransfersResponseModel) result  or error
*/
    func externalTransfers(skip: Int, limit: Int, addresses: [String],
                           completion: @escaping (Result<ETHExternalTransfersResponseModel, CryptoApiError>) -> Void)
    
/**
    Get transaction history from one address to another

    - Parameter skip: skip
    - Parameter limit: limit
    - Parameter fromAddress: from address
    - Parameter toAddress: to address
    - Parameter completion: Callback which returns an [ETHTransactionsResponseModel](ETHTransactionsResponseModel) result  or error
*/
    func transactions(skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<ETHTransactionsResponseModel, CryptoApiError>) -> Void)
    
/**
    Get transaction history from one address to another

    - Parameter hash: hash of transaction
    - Parameter completion: Callback which returns an [ETHTransactionResponseModel](ETHTransactionResponseModel) result  or error
*/
    func transaction(hash: String,
                     completion: @escaping (Result<ETHTransactionResponseModel, CryptoApiError>) -> Void)
    
/**
    Get contract info

    - Parameter address: contract address
    - Parameter completion: Callback which returns an [ETHContractInfoResponseModel](ETHContractInfoResponseModel) result  or error
*/
    func contractInfo(address: String,
                      completion: @escaping (Result<ETHContractInfoResponseModel, CryptoApiError>) -> Void)
    
/**
    Return list of tokens balances by holder address, when token balance is more than zero.

    - Parameter address: contract address
    - Parameter skip: skip
    - Parameter limit: limit
    - Parameter completion: Callback which returns an [ETHTokensBalanceResponseModel](ETHTokensBalanceResponseModel) result  or error
*/
    func tokensBalance(address: String, skip: Int, limit: Int,
                       completion: @escaping (Result<ETHTokensBalanceResponseModel, CryptoApiError>) -> Void)
    
/**
    Get token transfers

    - Parameter tokenAddress: token address
    - Parameter addresses: addresses
    - Parameter skip: skip
    - Parameter limit: limit
    - Parameter completion: Callback which returns an [ETHTokenTransfersResponseModel](ETHTokenTransfersResponseModel) result  or error
*/
    func tokenTransfers(tokenAddress: String, addresses: [String], skip: Int, limit: Int,
                        completion: @escaping (Result<ETHTokenTransfersResponseModel, CryptoApiError>) -> Void)
    
/**
    Get information about token contract

    - Parameter address: token address
    - Parameter completion: Callback which returns an [ETHTokenInfoResponseModel](ETHTokenInfoResponseModel) result  or error
*/
    func tokenInfo(address: String,
                   completion: @escaping (Result<ETHTokenInfoResponseModel, CryptoApiError>) -> Void)
    
/**
    Return search info about tokens

    - Parameter query: query
    - Parameter skip: skip
    - Parameter limit: limit
    - Parameter types: types
    - Parameter completion: Callback which returns an [ETHTokensQueryResponseModel](ETHTokensQueryResponseModel) result  or error
*/
    func tokenSearch(query: String, skip: Int, limit: Int, types: [String],
                     completion: @escaping (Result<ETHTokensQueryResponseModel, CryptoApiError>) -> Void)
    
/**
    Send raw eth transaction.

    - Parameter transaction: transaction
    - Parameter completion: Callback which returns an [String](String) result  or error
*/
    func sendRaw(transaction: String,
                 completion: @escaping (Result<String, CryptoApiError>) -> Void)
    
/**
    Decode raw eth transaction.

    - Parameter transaction: transaction
    - Parameter completion: Callback which returns an [ETHDecodeRawResponseModel](ETHDecodeRawResponseModel) result  or error
*/
    func decodeRaw(transaction: String,
                   completion: @escaping (Result<ETHDecodeRawResponseModel, CryptoApiError>) -> Void)
    
/**
    Executes a message call transaction

    - Parameter sender: sender
    - Parameter amount: amount
    - Parameter bytecode: bytecode
    - Parameter address: address
    - Parameter completion: Callback which returns an [String](String) result  or error
*/
    func callContract(sender: String, amount: Int, bytecode: String, address: String,
                      completion: @escaping (Result<String, CryptoApiError>) -> Void)
}
 