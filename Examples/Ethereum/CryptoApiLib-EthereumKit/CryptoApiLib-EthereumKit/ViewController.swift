//
//  ViewController.swift
//  CryptoApiLib-EthereumKit
//
//  Created by Andrey Matoshko on 6/29/21.
//

import UIKit
import EthereumKit
import CryptoApiLib
import BigInt

enum ExampleConstants {
    static let authToken = "Your token"
    
    static let fromAddress = "sender address"
    static let toAddress = "recipient address"
    static let sendAmount = "100000000000000"
    
    static let mnemonicHex = "000102030405060708090a0b0c0d0e0f"
    static let words = ["example","array", "of", "your", "brainkey", "words"]
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
    
    func configEthereumKit() -> Kit {
        // Initialize setting for EthereumKit with your parametrs.
        let ethereumKit = try! Kit.instance(
            words: ExampleConstants.words,
            syncMode: .api,
            rpcApi: .incubed,
            etherscanApiKey: "",
            walletId: "testWallet"
        )
        
        ethereumKit.start()
        
        return ethereumKit
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cryptoApi = configCryptoApiLib()
        let kit = configEthereumKit()

        let address = kit.address.description

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
                self.createTransaction(kit: kit) { hash in
                    // send buided transaction
                    self.sendRawTransaction(cryptoApi: cryptoApi, transactionHash: hash)
                }
                
                return
            case .failure(let error):
                print(error)
                return
            }
        }
    }

    func createTransaction(kit: Kit, comletion: @escaping ((String) -> Void)) {
        let amount = BigUInt(stringLiteral: ExampleConstants.sendAmount)
        let address = try! Address(hex: "0x73eb56f175916bd17b97379c1fdb5af1b6a82c84")

        kit
            .sendSingle(address: address, value: amount, gasPrice: 50_000_000_000, gasLimit: 1_000_000_000_000)
            .subscribe(onSuccess: { transaction in
                print("Transcation hash: \(transaction.transaction.hash.hex)")
                comletion(transaction.transaction.hash.hex)
                // sendSingle returns FullTransaction object which contains transaction, receiptWithLogs and internalTransactions
            })
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


