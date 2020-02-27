//
//  ViewController.swift
//  CryptoApiLib_CoreBitcoin
//
//  Created by Artemy Markovsky on 2/25/20.
//  Copyright © 2020 pixelplex. All rights reserved.
//

import UIKit
import CryptoApiLib

enum ExampleConstants {
    static let authToken = "Your token"
    
    static let changeAddress = "sender address"
    static let toAddress = "recipient address"
    static let sendAmount = 2100
    
    static let password: String? = nil
    static let mnemonicArray = ["array", "of", "your", "brainkey", "words"]
}

class ViewController: UIViewController {
    
    func configCryptoApiLib() -> CryptoAPI {
        let settings = Settings(authorizationToken: ExampleConstants.authToken) { configurator in
            configurator.networkType = NetworkType.testnet
        }
        let api = CryptoAPI(settings: settings)
        return api
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cryptoApi = configCryptoApiLib()
        
        let mnemonic = BTCMnemonic(words: ExampleConstants.mnemonicArray, password: ExampleConstants.password, wordListType: .english)!
        let keychain = mnemonic.keychain.derivedKeychain(withPath: "m/44'/1'/0'/0/0")!
        let key = keychain.key!
        
        // CHANGE LIMIT TO nil
        var responseOutputs: [BTCAddressOutputResponseModel]?
        cryptoApi.btc.addressesOutputs(addresses: [key.address.string], status: "unspent",
                                       skip: 0, limit: 25) { result in
                                        switch result {
                                        case let .success(outModels):
                                            responseOutputs = outModels
                                            for output in outModels {
                                                print(output.value)
                                            }
                                        case let .failure(error):
                                            print(error)
                                        }
        }
        
        var outputs = mapOutputsResponse(model: responseOutputs!)
        let changeAddress = BTCAddress(string: ExampleConstants.changeAddress)
        let toAddress = BTCAddress(string: ExampleConstants.toAddress)
        let value = BTCAmount(ExampleConstants.sendAmount)
        let fee = BTCAmount(1000)
        
        let transaction = BTCTransaction()
        transaction.fee = fee
        
        var spentCoins = BTCAmount(0)
        
        for txOut in outputs {
            let txIn = BTCTransactionInput()
            txIn.previousHash = txOut.transactionHash
            txIn.previousIndex = txOut.index
            txIn.value = txOut.value
            txIn.signatureScript = txOut.script
            
            transaction.addInput(txIn)
            spentCoins += txOut.value
        }
        
        let paymentOutput = BTCTransactionOutput(value: BTCAmount(value), address: toAddress)
        transaction.addOutput(paymentOutput)
        
        if spentCoins > (value + fee) {
            let changeValue = spentCoins - (value + fee)
            let changeOutput = BTCTransactionOutput(value: changeValue, address: changeAddress)
            transaction.addOutput(changeOutput)
        }
        
        for i in 0..<outputs.count {
            let txOut = outputs[i]
            let txIn = transaction.inputs[i] as! BTCTransactionInput
            
            let hash = try! transaction.signatureHash(for: txOut.script, inputIndex: UInt32(i), hashType: .SIGHASH_ALL)
            
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
        
        let transactionHex = BTCHexFromData(transaction.data)!
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
