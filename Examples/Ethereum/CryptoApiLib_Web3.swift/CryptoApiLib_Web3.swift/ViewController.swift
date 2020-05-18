//
//  ViewController.swift
//  CryptoApiLib_Web3.swift
//
//  Created by Artemy Markovsky on 2/24/20.
//  Copyright © 2020 pixelplex. All rights reserved.
//

import UIKit
import Web3
import CryptoApiLib

enum ExampleConstants {
    static let authToken = "Your authorization token"
    
    static let toAddress = "recipient address"
    static let sendAmount = "1000000000000000000"
    
    static let privateKey = "0xa26da69ed1df3ba4bb2a231d506b711eace012f1bd2571dfbfff9650b03375af"
}

class ViewController: UIViewController {
    
    func configCryptoApiLib() -> CryptoAPI {
        // Initialize setting for CryptoApi with your authorization token.
        let apiSettings = Settings(authorizationToken: ExampleConstants.authToken) { configurator in
            configurator.networkType = NetworkType.testnet
        }
        let cryptoApi = CryptoAPI(settings: apiSettings)
        
        return cryptoApi
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cryptoApi = configCryptoApiLib()
        
        // generate address
        let privateKey = try! EthereumPrivateKey(hexPrivateKey: ExampleConstants.privateKey)
        let address = privateKey.address.hex(eip55: true)
        print("ETH Address: \(address)")
        
        cryptoApi.eth.balance(addresses: [address]) { result in
            switch result {
            case .success(let addressesBalancesArray):
                for item in addressesBalancesArray {
                    print("Balance: \(item.balance)")
                }
            
            case .failure(let error):
                print(error)
            }
        }
        
        // estimate gas for transaction
        cryptoApi.eth.estimateGas(fromAddress: privateKey.address.hex(eip55: true),
                                  toAddress: privateKey.address.hex(eip55: true),
                                  data: "", value: ExampleConstants.sendAmount) { result in
            switch result {
            case .success(let response):
                print("nonse: \(response.nonce), gas prise: \(response.gasPrice), estimate: \(response.estimateGas).")
                
                // prepare transaction for send
                let transaction = self.prepareTransaction(estimatedGas: response, privateKey: privateKey)
                
                // sign transaction
                let signedTransaction = try! transaction.sign(with: privateKey)
                
                // send builded raw transaction
                self.sendRawTransaction(cryptoApi: cryptoApi, signedTransaction: signedTransaction)
                
                return
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func prepareTransaction(estimatedGas: ETHEstimateGasResponseModel, privateKey: EthereumPrivateKey) -> EthereumTransaction {
        let nonce = EthereumQuantity(quantity: BigUInt(estimatedGas.nonce))
        let gasPrice = EthereumQuantity(quantity: try! BigUInt(estimatedGas.gasPrice))
        let gasLimit = EthereumQuantity(quantity: BigUInt(estimatedGas.estimateGas))
        let value = EthereumQuantity(quantity: 1.eth)
        let toAddress = try! EthereumAddress(hex: ExampleConstants.toAddress, eip55: true)
        
        let transaction = EthereumTransaction(
            nonce: nonce,
            gasPrice: gasPrice,
            gas: gasLimit,
            from: privateKey.address,
            to: toAddress,
            value: value
        )
        
        return transaction
    }
    
    func sendRawTransaction(cryptoApi: CryptoAPI, signedTransaction: EthereumSignedTransaction) {
        let transactionHex = try! RLPEncoder().encode(signedTransaction.rlp()).toHexString()
        
        cryptoApi.eth.sendRaw(transaction: transactionHex) { result in
            switch result {
            case .success(let txResponse):
                print(txResponse.hash)
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
}
