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

class ViewController: UIViewController {
    
    func configCryptoApiLib() -> CryptoAPI {
        // Initialize CryptoApi setting with your authorization token.
        let apiSettings = Settings(authorizationToken: "Your token") { configurator in
            configurator.networkType = NetworkType.testnet
        }
        let cryptoApi = CryptoAPI(settings: apiSettings)
        
        return cryptoApi
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cryptoApi = configCryptoApiLib()
        
        let mnemonicString = "your mnemonic words"
        
        let keystore = try! BIP32Keystore(mnemonics: mnemonicString,
                                          password: "",
                                          mnemonicsPassword: "",
                                          language: .english)!
        let keystoreManager = KeystoreManager([keystore])
        let web = web3(provider: InfuraProvider(.Rinkeby)!)
        web.addKeystoreManager(keystoreManager)
        
        let account = try! web.wallet.getAccounts().first!
        let address = keystore.addresses!.first!.address
        
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
        
        let toAddress = "to address"
        let value = "10000"
        var estimatedGas: ETHEstimateGasResponseModel?
        cryptoApi.eth.estimateGas(fromAddress: address, toAddress: toAddress, data: "", value: value) { result in
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
        
        guard let fee = estimatedGas else {
            return
        }
        
        let ethToAddress = EthereumAddress(toAddress)!
        
        let nonce = BigUInt(fee.nonce)
        let gasLimit = BigUInt(fee.estimateGas)
        let gasPrice = BigUInt(fee.gasPrice)!
        let intTransactionValue = BigUInt(value)!
        
        let v = BigUInt(0)
        let r = BigUInt(0)
        let s = BigUInt(0)
        
        var transaction = EthereumTransaction(nonce: nonce, gasPrice: gasPrice,
                                              gasLimit: gasLimit, to: ethToAddress,
                                              value: intTransactionValue, data: Data(),
                                              v: v,
                                              r: r,
                                              s: s)
        transaction.UNSAFE_setChainID(BigUInt(4)) // "4" for Rinkeby provider
        
        try! Web3Signer.signTX(transaction: &transaction, keystore: keystoreManager, account: account, password: "")
        let transactionHash = transaction.encode()!.toHexString()
        
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
