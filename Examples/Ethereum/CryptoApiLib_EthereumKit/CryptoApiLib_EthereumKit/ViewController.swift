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

class ViewController: UIViewController {
    
    func configCryptoApiLib() -> CryptoAPI {
        // Initialize setting for CryptoApi with your authorization token.
        let apiSettings = Settings(authorizationToken: "Your token") { configurator in
            configurator.networkType = NetworkType.testnet
        }
        let cryptoApi = CryptoAPI(settings: apiSettings)
        
        return cryptoApi
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cryptoApi = configCryptoApiLib()
        
        let mnemonic = Mnemonic.create(entropy: Data(hex: "000102030405060708090a0b0c0d0e0f"))
        let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
        
        let wallet: Wallet
        do {
            wallet = try Wallet(seed: seed, network: .ropsten, debugPrints: true)
        } catch let error {
            fatalError("Error: \(error.localizedDescription)")
        }
        
        let address = wallet.address()
        
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
        
        var estimatedGas: ETHEstimateGasResponseModel?
        cryptoApi.eth.estimateGas(fromAddress: "from address", toAddress: "to address", data: "", value: "value") { result in
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
        guard let value = try? Converter.toWei(ether: "0.0001") else {
            print("Invalid transaction value")
            return
        }
        let rawTransaction = RawTransaction(value: value, to: address, gasPrice: Int(fee.gasPrice)!, gasLimit: fee.estimateGas, nonce: fee.nonce)
        let transactionHash: String
        do {
            transactionHash = try wallet.sign(rawTransaction: rawTransaction)
        } catch let error {
            fatalError("Error: \(error.localizedDescription)")
        }
        
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
