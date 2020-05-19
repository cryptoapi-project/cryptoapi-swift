//
//  ViewController.swift
//  CryptoApiLib_CoreLitecoin
//
//  Created by Alexander Eskin on 5/19/20.
//  Copyright © 2020 PixelPlex. All rights reserved.
//

import CryptoApiLib
import UIKit

enum ExampleConstants {
    static let authToken = "Your token"
    static let mainnetDerivationPath = "m/44'/0'/0'/0/0"
    static let testnetDerivationPath = "m/44'/1'/0'/0/0"
    
    static let changeAddress = "sender address"
    static let toAddress = "recipient address"
    static let sendAmount = 2100
    
    static let password: String? = nil
    static let mnemonicArray = ["array", "of", "your", "brainkey", "words"]
    
}

class ViewController: UIViewController {
    func configCryptoApiLib() -> CryptoAPI {
        // Initialize setting for CryptoApi with your authorization token.
        let settings = Settings(authorizationToken: ExampleConstants.authToken) { configurator in
            configurator.networkType = NetworkType.testnet
        }
        let cryptoApi = CryptoAPI(settings: settings)
        
        return cryptoApi
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cryptoApi = configCryptoApiLib()
        
        let mnemonic: LTCMnemonic! = LTCMnemonic(
            words: ExampleConstants.mnemonicArray,
            password: ExampleConstants.password,
            wordListType: .english
            )
        let keychain = mnemonic.keychain.derivedKeychain(withPath: ExampleConstants.testnetDerivationPath)!
        let key = keychain.key!
        
        // MARK: Get outputs
        // Get address unspent outputs to calculate balance or build the transaction
        
        cryptoApi.ltc.addressesOutputs(addresses: [key.addressTestnet.string], status: "unspent", skip: 0, limit: nil) { result in
            switch result {
            case .success(let outputs):
                for output in outputs {
                    print("Output Value: \(output.value)")
                }
                
                // MARK: Build transaction
                let transactionHex = self.createTransaction(key: key, outputs: outputs)
                
                // MARK: Send transaction
                self.sendRawTransaction(transactionHex: transactionHex)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // MARK: Fee estimating
        
        // First of all, you need to get fee rate for kilobyte
        cryptoApi.ltc.feePerKb { result in
            switch result {
            case .success(let feeString):
                // Response has result like "0.00001". Convert it to litoshis if necessary.
                let feePerKb = Double(feeString)! * 10000000
                
                self.estimateFee(feePerKb: LTCAmount(feePerKb))
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func estimateFee(feePerKb: LTCAmount) {
        // We need to calculate how much the transaction weighs and how many outs we need to take in transaction
        // to cover the amount sent and the fee.
        var resultFee = feePerKb
        let fee = LTCAmount(3800)
        
        let maxFee = 100000000 // fee cannot be greater than 1 LTC (100000000 litoshi)
        while fee < maxFee {
            let transaction = LTCTransaction() // build transaction like example above.
            
            let validFee = transaction.estimatedFee(withRate: feePerKb)
            
            if validFee <= fee {
                resultFee = validFee
                break
            }
            
            resultFee += feePerKb
        }
        // resultFee is the result of estimation of fee
        print(resultFee)
    }
    
    func createTransaction(key: LTCKey, outputs: [LTCAddressOutputResponseModel]) -> String {
        // Prepare values for transaction
        let outputs = mapOutputsResponse(model: outputs)
        let changeAddress = LTCAddress(string: ExampleConstants.changeAddress)
        let toAddress = LTCAddress(string: ExampleConstants.toAddress)
        let value = LTCAmount(ExampleConstants.sendAmount)
        let fee = LTCAmount(4000)
        
        let transaction = LTCTransaction()
        transaction.fee = fee
        
        var spentCoins = LTCAmount(0)
        
        // Convert each output to transaction input
        for txOut in outputs {
            let txIn = LTCTransactionInput()
            txIn.previousHash = txOut.transactionHash
            txIn.previousIndex = txOut.index
            txIn.value = txOut.value
            txIn.signatureScript = txOut.script
            
            transaction.addInput(txIn)
            spentCoins += txOut.value
        }
        
        // Prepare outputs for transaction
        let paymentOutput = LTCTransactionOutput(value: LTCAmount(value), address: toAddress)
        transaction.addOutput(paymentOutput)
        
        // If you have a change, then create output with your change address
        if spentCoins > (value + fee) {
            let changeValue = spentCoins - (value + fee)
            let changeOutput = LTCTransactionOutput(value: changeValue, address: changeAddress)
            transaction.addOutput(changeOutput)
        }
        
        // Sign the transaction
        for i in 0..<outputs.count {
            let txOut = outputs[i]
            let txIn = transaction.inputs[i] as! LTCTransactionInput
            
            let hash = try! transaction.signatureHash(for: txOut.script, inputIndex: UInt32(i), hashType: .signatureHashTypeAll)
            let signature = key.signature(forHash: hash)
            var signatureForScript = signature
            
            let hashTypeData = LTCSignatureHashType.signatureHashTypeAll.rawValue
            var hashType = hashTypeData
            
            signatureForScript?.append(&hashType, count: 1)
            
            let sigScript = LTCScript()
            _ = sigScript?.appendData(signatureForScript)
            _ = sigScript?.appendData(key.publicKey as Data?)
            
            txIn.signatureScript = sigScript
        }
        
        // Get a transaction hex and send it with CryptoApi
        let transactionHex = LTCHexFromData(transaction.data)!
        print(transactionHex)
        
        return transactionHex
    }
    
    func sendRawTransaction(transactionHex: String) {
        let cryptoApi = configCryptoApiLib()
        cryptoApi.ltc.sendRaw(transaction: transactionHex) { result in
            switch result {
            case .success(let response):
                print("Transaction Hash: \(response.result)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController {
    // Use this method if you want to select optimal number of outputs.
    func selectNeededOutputs(for value: Int64, from: [LTCTransactionOutput]) ->
        (outs: [LTCTransactionOutput], selectedOutsAmount: LTCAmount)? {
        var neededOuts = [LTCTransactionOutput]()
        var total: LTCAmount = 0
        var utxos = from
        
        guard utxos.count > 0 else {
            return nil
        }
        
        utxos = utxos.sorted(by: { $0.value < $1.value })
        for txout in utxos {
            
            if txout.script.isPayToPublicKeyHashScript {
                neededOuts.append(txout)
                total += txout.value
            }
            
            if total >= value {
                break
            }
        }
        
        if total < value {
            return nil
        }
        
        return (neededOuts, total)
    }
    
    func mapOutputsResponse(model: [LTCAddressOutputResponseModel])  -> [LTCTransactionOutput] {
        var outputs = [LTCTransactionOutput]()
        
        for item in model {
            let out = LTCTransactionOutput()
            out.value = LTCAmount(item.value)
            out.script = LTCScript(data: LTCDataFromHex(item.script))
            out.transactionHash = LTCDataFromHex(item.mintTransactionHash.invertHex())
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
            let start = index(startIndex, offsetBy: charIndex)
            let end = index(startIndex, offsetBy: charIndex + 2)
            let substring = hexString[start..<end]
            let first: Character! = substring.first
            let last: Character! = substring.last
            reversedString += String(describing: String(first))
            reversedString += String(describing: String(last))
        }
        
        return reversedString
    }
}
