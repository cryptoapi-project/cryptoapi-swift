//
//  ViewController.swift
//  CryptoApiLib_web3swift
//
//  Created by Artemy Markovsky on 2/21/20.
//  Copyright © 2020 pixelplex. All rights reserved.
//

import UIKit
import web3swift
import BigInt
import CryptoApiLib

enum ExampleConstants {
    static let authToken = "Your authorization token"
    
    static let toAddress = "recipient address"
    static let sendAmount = "1000000000000000000"
    
    static let password = "recipient address"
    static let mnemonicsPassword = ""
    static let mnemonicString = "mnemonic of your address"
    static let privateKey = "0xa26da69ed1df3ba4bb2a231d506b711eace012f1bd2571dfbfff9650b03375af"
}

class ViewController: UIViewController {
    
    func configCryptoApiLib() -> CryptoAPI {
        // Initialize CryptoApi setting with your authorization token.
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
        let mnemonicString = ExampleConstants.mnemonicString
        let keystore = try! BIP32Keystore(mnemonics: mnemonicString,
                                          password: ExampleConstants.password,
                                          mnemonicsPassword: ExampleConstants.mnemonicsPassword,
                                          language: .english)!
        let keystoreManager = KeystoreManager([keystore])
        let web = web3(provider: InfuraProvider(.Rinkeby)!)
        web.addKeystoreManager(keystoreManager)
        
        let account = try! web.wallet.getAccounts().first!
        let address = keystore.addresses!.first!.address
        
        // get balance for generated account
        cryptoApi.eth.balance(addresses: [address]) { result in
            switch result {
            case .success(let addressesBalancesArray):
                for item in addressesBalancesArray {
                    print(item.balance)
                }
                
            case .failure(let error):
                print(error)
            }
        }

        // estimate gas for transaction
        var estimatedGas: ETHEstimateGasResponseModel?
        cryptoApi.eth.estimateGas(
            fromAddress: address, toAddress: ExampleConstants.toAddress,
            data: "",
            value: ExampleConstants.sendAmount
        ) { result in
            switch result {
            case .success(let response):
                estimatedGas = response
                print("nonse: \(response.nonce), gas prise: \(response.gasPrice), estimate: \(response.estimateGas).")
                return
            case .failure(let error):
                print(error)
                return
            }
        }
        
        // build transaction
        guard let fee = estimatedGas else {
            return
        }
        
        let ethToAddress = EthereumAddress(ExampleConstants.toAddress)!
        let intTransactionValue = BigUInt(ExampleConstants.sendAmount)!
        let nonce = BigUInt(fee.nonce)
        let gasLimit = BigUInt(fee.estimateGas)
        let gasPrice = BigUInt(fee.gasPrice)!
        
        let v = BigUInt(0)
        let r = BigUInt(0)
        let s = BigUInt(0)
        
        var transaction = EthereumTransaction(
            nonce: nonce, gasPrice: gasPrice,
            gasLimit: gasLimit, to: ethToAddress,
            value: intTransactionValue, data: Data(),
            v: v, r: r, s: s
        )
        transaction.UNSAFE_setChainID(BigUInt(4)) // "4" for Rinkeby provider
        
        // sing the transaction
        try! Web3Signer.signTX(transaction: &transaction, keystore: keystoreManager, account: account, password: "")
        let transactionHash = transaction.encode()!.toHexString()
        
        // send builded transaction
        cryptoApi.eth.sendRaw(transaction: transactionHash) { result in
            switch result {
            case .success(let response):
                print(response.hash)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
