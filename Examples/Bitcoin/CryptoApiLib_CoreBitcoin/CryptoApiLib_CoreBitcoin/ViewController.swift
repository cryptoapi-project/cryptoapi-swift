//
//  ViewController.swift
//  CryptoApiLib_CoreBitcoin
//
//  Created by Artemy Markovsky on 2/25/20.
//  Copyright © 2020 pixelplex. All rights reserved.
//

import UIKit
import CryptoApiLib

class ViewController: UIViewController {

    func configCryptoApiLib() -> CryptoAPI {
        // Or you can use custom configuration
        let settings = Settings(authorizationToken: "Your token") { configurator in
            configurator.networkType = NetworkType.testnet
            configurator.debugEnabled = true
        }
        let api = CryptoAPI(settings: settings)
        return api
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cryptoApi = configCryptoApiLib()
        
        guard let mnemonic = BTCMnemonic(words: ["array", "of", "your", "brainkey", "words"], password: nil, wordListType: .english) else {
            print("Error: Invalid mnemonic input.")
            return
        }
        guard let seed = mnemonic.words as? [String] else {
            print("Error: Seed generating error.")
            return
        }

        guard let keychain = mnemonic.keychain.derivedKeychain(withPath: "m/44'/1'/0'/0/0"),
            let key = keychain.key else {
                print("Error: Keychain generating error.")
                return
        }
        
        cryptoApi.btc.addressesOutputs(addresses: [key.address.string], status: "unspent", skip: 0, limit: 25) { result in
            switch result {
            case let .success(outModels):
                var outputs: [__ObjC.BTCTransactionOutput] = []
                let changeAddress = BTCAddress(string: "from Address or other")
                let toAddress = BTCAddress(string: "to Address")
                let value = BTCAmount(2100)
                let fee = BTCAmount(1000)
                
                let tx = BTCTransaction()
                tx.fee = fee
                
                var spentCoins = BTCAmount(0)
                
                for txOut in outputs {
                    let txIn = BTCTransactionInput()
                    txIn.previousHash = txOut.transactionHash
                    txIn.previousIndex = txOut.index
                    txIn.value = txOut.value
                    txIn.signatureScript = txOut.script
                    
                    tx.addInput(txIn)
                    spentCoins += txOut.value
                }
                
                let paymentOutput = BTCTransactionOutput(value: BTCAmount(value), address: toAddress)
                tx.addOutput(paymentOutput)
                
                if spentCoins > (value + fee) {
                    let changeValue = spentCoins - (value + fee)
                    let changeOutput = BTCTransactionOutput(value: changeValue, address: changeAddress)
                    tx.addOutput(changeOutput)
                }
                
                for i in 0..<outputs.count {
                    let txOut = outputs[i]
                    let txIn = tx.inputs[i] as! BTCTransactionInput
                    
                    guard let hash = try? tx.signatureHash(for: txOut.script, inputIndex: UInt32(i), hashType: .SIGHASH_ALL) else {
                        return
                    }
                    
                    let sigScript = BTCScript()
                    
                    let signature = key.signature(forHash: hash)
                    var signatureForScript = signature
                    let hashTypeData = BTCSignatureHashType.SIGHASH_ALL.rawValue
                    var hashType = hashTypeData
                    signatureForScript?.append(&hashType, count: 1)
                    _ = sigScript?.appendData(signatureForScript)
                    _ = sigScript?.appendData(key.publicKey as Data?)
                    
                    if !key.isValidSignature(signature, hash: hash) {
                        return
                    }

                    txIn.signatureScript = sigScript
                }

            case let .failure(error):
                print(error)
            }
        }
    }
}

extension ViewController {
    func mapOutputsResponse(model: [BTCAddressOutputResponseModel])  -> [BTCTransactionOutput] {
        var outputs = [BTCTransactionOutput]()
        
        for item in model {
            let out = BTCTransactionOutput()
            out.value = BTCAmount(item.value)
            out.script = BTCScript(data: BTCDataFromHex(item.script))
            out.transactionHash = BTCDataFromHex(item.mintTransactionHash.invertHex())
            out.index = UInt32(item.mintIndex)
            out.blockHeight = item.mintBlockHeight
            
            outputs.append(out)
        }
        
        return outputs
    }
}

private extension String {
    
    func invertHex() -> String {
        
        let hexString = String(self)
        var reversedString = String()
        var charIndex = self.count
        
        while charIndex > 0 {
            charIndex -= 2
            let substring = hexString[charIndex..<charIndex+2]
            reversedString += String(describing: substring.first!)
            reversedString += String(describing: substring.last!)
        }
        
        return reversedString
    }
}
