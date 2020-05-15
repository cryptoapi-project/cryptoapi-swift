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
    
    static let password = "keystore password"
    static let mnemonicsPassword = "mnemonic's password"
    static let mnemonicString = "mnemonic of your address"
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
        print("Address \(address)")
        
        // get balance for generated account
        cryptoApi.eth.balance(addresses: [address]) { result in
            switch result {
            case .success(let addressesBalancesArray):
                for item in addressesBalancesArray {
                    print("Balance \(item.balance)")
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        // estimate gas for transaction
        cryptoApi.eth.estimateGas(fromAddress: address, toAddress: ExampleConstants.toAddress,
                                  data: "", value: ExampleConstants.sendAmount) { result in
            switch result {
            case .success(let response):
                print("nonse: \(response.nonce), gas prise: \(response.gasPrice), estimate: \(response.estimateGas).")
                
                
                // build transaction and get transaction hash
                let transactionHash = self.createTransaction(response: response, keystore: keystore, account: account)
                
                // send builded transaction
                self.sendRawTransaction(cryptoApi: cryptoApi, transactionHash: transactionHash)
                
                return
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func createTransaction(response: ETHEstimateGasResponseModel, keystore: BIP32Keystore, account: EthereumAddress) -> String {
        let ethToAddress = EthereumAddress(ExampleConstants.toAddress)!
        let intTransactionValue = BigUInt(ExampleConstants.sendAmount)!
        let nonce = BigUInt(response.nonce)
        let gasLimit = BigUInt(response.estimateGas)
        let gasPrice = BigUInt(response.gasPrice)!
        
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
        try! Web3Signer.signTX(transaction: &transaction, keystore: keystore, account: account, password: ExampleConstants.password)
        let transactionHash = transaction.encode()!.toHexString()
        
        return transactionHash
    }
    
    func sendRawTransaction(cryptoApi: CryptoAPI, transactionHash: String) {
        cryptoApi.eth.sendRaw(transaction: "0x" + transactionHash) { result in
            switch result {
            case .success(let response):
                print(response.hash)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
