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

class ViewController: UIViewController {
    
    func configCryptoApiLib() -> CryptoAPI {
        // Initialize setting for CryptoApi with your authorization token.
        let apiSettings = Settings(authorizationToken: "5de552d7efc6ff2e1b09d946cc5263e346003a93ab28bf2ffeb24979da85a1f5") { configurator in
            configurator.networkType = NetworkType.testnet
        }
        let cryptoApi = CryptoAPI(settings: apiSettings)
        
        return cryptoApi
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cryptoApi = configCryptoApiLib()
        
        let privateKey = try! EthereumPrivateKey(hexPrivateKey: "0xa26da69ed1df3ba4bb2a231d506b711eace012f1bd2571dfbfff9650b03375af")
        let address = privateKey.address.hex(eip55: true)
        print(address)
        
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
        cryptoApi.eth.estimateGas(fromAddress: privateKey.address.hex(eip55: true), toAddress: privateKey.address.hex(eip55: true), data: "", value: "1000000000000000000") { result in
            switch result {
            case .success(let response):
                estimatedGas = response
                print("nonse: \(response.nonce), gas prise: \(response.gasPrice), estimate: \(response.estimateGas).")
                
                let nonce = EthereumQuantity(quantity: BigUInt(estimatedGas!.nonce))
                let gasPrice = EthereumQuantity(quantity: try! BigUInt(estimatedGas!.gasPrice))
                let gasLimit = EthereumQuantity(quantity: BigUInt(estimatedGas!.estimateGas))
                let value = EthereumQuantity(quantity: 1.eth)
                guard let toAddress = try? EthereumAddress(hex: "to addres hex", eip55: true) else {
                    return
                }
                
                let transaction = EthereumTransaction(nonce: nonce, gasPrice: gasPrice, gas: gasLimit, from: privateKey.address, to: toAddress, value: value)
                
                guard let signedTransaction = try? transaction.sign(with: privateKey) else {
                    return
                }
                
                cryptoApi.eth.sendRaw(transaction: signedTransaction.data.hex()) { result in
                    switch result {
                    case .success(let txResponse):
                        print(txResponse.hash)
                    case .failure(let error):
                        print(error.localizedDescription)
                        return
                    }
                }
                
                return
            case .failure(let error):
                print(error)
                return
            }
        }
    }
}

