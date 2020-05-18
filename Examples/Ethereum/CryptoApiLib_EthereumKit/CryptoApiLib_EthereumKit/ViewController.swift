//
//  ViewController.swift
//  CryptoApiLib_EthereumKit
//
//  Created by Artemy Markovsky on 2/24/20.
//  Copyright © 2020 pixelplex. All rights reserved.
//

import UIKit
import EthereumKit
import CryptoApiLib

enum ExampleConstants {
    static let authToken = "Your token"
    
    static let fromAddress = "sender address"
    static let toAddress = "recipient address"
    static let sendAmount = "100000000000000"
    
    static let mnemonicHex = "000102030405060708090a0b0c0d0e0f"
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
        let mnemonic = Mnemonic.create(entropy: Data(hex: ExampleConstants.mnemonicHex))
        let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
        let wallet = try! Wallet(seed: seed, network: .private(chainID: 4, testUse: true), debugPrints: true)
        
        let address = wallet.address()
        
        // get generated address
        cryptoApi.eth.balance(addresses: [address]) { result in
            switch result {
            case .success(let addressesBalancesArray):
                for item in addressesBalancesArray {
                    print("Balance \(item.balance) wei")
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        // estimate gas for transaction
        cryptoApi.eth.estimateGas(fromAddress: ExampleConstants.fromAddress, toAddress: ExampleConstants.toAddress, data: "", value: ExampleConstants.sendAmount) { result in
            switch result {
            case .success(let response):
                print("nonse: \(response.nonce), gas prise: \(response.gasPrice), estimate: \(response.estimateGas).")
                
                // build transaction and get transaction hash
                let transactionHash = self.createTransaction(response: response, wallet: wallet)
                
                // send buided transaction
                self.sendRawTransaction(cryptoApi: cryptoApi, transactionHash: transactionHash)
                
                return
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func createTransaction(response: ETHEstimateGasResponseModel, wallet: Wallet) -> String {
        let value = Wei(ExampleConstants.sendAmount)!
        
        let rawTransaction = RawTransaction(
            value: value,
            to: ExampleConstants.toAddress,
            gasPrice: Int(response.gasPrice)!,
            gasLimit: response.estimateGas,
            nonce: response.nonce
        )
        let transactionHash = try! wallet.sign(rawTransaction: rawTransaction)
        
        return transactionHash
    }
    
    func sendRawTransaction(cryptoApi: CryptoAPI, transactionHash: String) {
        cryptoApi.eth.sendRaw(transaction: transactionHash) { result in
            switch result {
            case .success(let response):
                print(response.hash)
                return
                
            case .failure(let error):
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
