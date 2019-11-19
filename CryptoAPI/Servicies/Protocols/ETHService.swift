//
//  ETHService.swift
//  CryptoAPI
//
//  Created by Fedorenko Nikita on 11/16/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

public protocol ETHService {
    func balance(addresses: [String],
                 completion: @escaping (Result<[ETHBalanceResponseModel], CryptoApiError>) -> Void)
    func estimateGas(fromAddress: String, toAddress: String, data: String, value: String,
                     completion: @escaping (Result<ETHEstimateGasResponseModel, CryptoApiError>) -> Void)
    func network(completion: @escaping (Result<ETHNetworkResponseModel, CryptoApiError>) -> Void)
    func info(addresses: [String],
              completion: @escaping (Result<[ETHInfoResponseModel], CryptoApiError>) -> Void)
    func transfers(skip: Int, limit: Int, addresses: [String], positive: String,
                   completion: @escaping (Result<ETHTransfersResponseModel, CryptoApiError>) -> Void)
    func externalTransfers(skip: Int, limit: Int, addresses: [String],
                           completion: @escaping (Result<ETHExternalTransfersResponseModel, CryptoApiError>) -> Void)
    func transactions(skip: Int, limit: Int, fromAddress: String, toAddress: String,
                      completion: @escaping (Result<ETHTransactionsResponseModel, CryptoApiError>) -> Void)
    func transaction(hash: String,
                     completion: @escaping (Result<ETHTransactionResponseModel, CryptoApiError>) -> Void)
    func contractInfo(addresses: [String],
                      completion: @escaping (Result<ETHContractInfoResponseModel, CryptoApiError>) -> Void)
    func tokensBalance(addresses: [String], skip: Int, limit: Int,
                       completion: @escaping (Result<ETHTokensBalanceResponseModel, CryptoApiError>) -> Void)
    func tokenTransfers(tokenAddress: String, addresses: [String], skip: Int, limit: Int,
                        completion: @escaping (Result<ETHTokenTransfersResponseModel, CryptoApiError>) -> Void)
    func tokenInfo(addresses: [String],
                   completion: @escaping (Result<ETHTokenInfoResponseModel, CryptoApiError>) -> Void)
    func tokenSearch(query: String, skip: Int, limit: Int, types: [String],
                     completion: @escaping (Result<ETHTokensQueryResponseModel, CryptoApiError>) -> Void)
}
 
