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
        
        let mnemonic = BTCMnemonic(words: ExampleConstants.mnemonicArray,
                                   password: ExampleConstants.password,
                                   wordListType: .english)!
        let keychain = mnemonic.keychain.derivedKeychain(withPath: ExampleConstants.testnetDerivationPath)!
        let key = keychain.key!
        
        // MARK: Get outputs
        // get address unspent outputs to calculate balance or build the transaction
        var responseOutputs: [BTCAddressOutputResponseModel]?
        cryptoApi.btc.addressesOutputs(
            addresses: [key.address.string],
            status: "unspent",
            skip: 0,
            limit: nil
        ) {
            result in
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
        
        // MARK: Build transaction
        
        // prepare values for transaction
        let outputs = mapOutputsResponse(model: responseOutputs!)
        let changeAddress = BTCAddress(string: ExampleConstants.changeAddress)
        let toAddress = BTCAddress(string: ExampleConstants.toAddress)
        let value = BTCAmount(ExampleConstants.sendAmount)
        let fee = BTCAmount(1000)
        
        let transaction = BTCTransaction()
        transaction.fee = fee
        
        var spentCoins = BTCAmount(0)
        
        // convert each output to transaction input
        for txOut in outputs {
            let txIn = BTCTransactionInput()
            txIn.previousHash = txOut.transactionHash
            txIn.previousIndex = txOut.index
            txIn.value = txOut.value
            txIn.signatureScript = txOut.script
            
            transaction.addInput(txIn)
            spentCoins += txOut.value
        }
        
        // prepare outputs for transaction
        let paymentOutput = BTCTransactionOutput(value: BTCAmount(value), address: toAddress)
        transaction.addOutput(paymentOutput)
        
        // if you have a change, then create output with your change address
        if spentCoins > (value + fee) {
            let changeValue = spentCoins - (value + fee)
            let changeOutput = BTCTransactionOutput(value: changeValue, address: changeAddress)
            transaction.addOutput(changeOutput)
        }
        
        // sign the transaction
        for i in 0..<outputs.count {
            let txOut = outputs[i]
            let txIn = transaction.inputs[i] as! BTCTransactionInput
            
            let hash = try! transaction.signatureHash(for: txOut.script, inputIndex: UInt32(i), hashType: .SIGHASH_ALL)
            let signature = key.signature(forHash: hash)
            var signatureForScript = signature
            
            let hashTypeData = BTCSignatureHashType.SIGHASH_ALL.rawValue
            var hashType = hashTypeData
            
            signatureForScript?.append(&hashType, count: 1)
            
            let sigScript = BTCScript()
            _ = sigScript?.appendData(signatureForScript)
            _ = sigScript?.appendData(key.publicKey as Data?)
            
            txIn.signatureScript = sigScript
        }
        
        // get a transaction hex and send it with CryptoApi
        let transactionHex = BTCHexFromData(transaction.data)!
        cryptoApi.btc.sendRaw(transaction: transactionHex) { result in
            switch result {
            case .success(let response):
                print(response.result)
            case .failure(let error):
                print(error)
            }
        }
        
        // MARK: Fee estimating
        
        //firs of all, you need to get fee rate for kilobyte
        var feePerKb: BTCAmount?
        cryptoApi.btc.feePerKb { result in
            switch result {
            case .success(let feeString):
                // response has result like "0.00001". Convert it to satoshi if necessary.
                let feeSatoshi = Double(feeString)! * 10000000
                feePerKb = BTCAmount(feeSatoshi)
            case .failure(let error):
                print(error)
            }
        }
        
        //we need to calculate how much the transaction weighs and how many outs we need to take in transaction
        //  to cover the amount sent and the fee.
        var resultFee = feePerKb
        
        let maxFee = 100000000 //fee cannot be greater than 1 btc (100000000 satoshi)
        while fee < maxFee {
            let transaction = BTCTransaction() //build transaction like example above.
            
            let validFee = transaction.estimatedFee(withRate: feePerKb!)
            
            if validFee <= fee {
                resultFee = validFee
                break
            }
            
            resultFee! += feePerKb!
        }
        // resultFee is the result of estimation of fee
    }
}

extension ViewController {
    // Use this method if you want to select optimal number of outputs.
    func selectNeededOutputs(for value: Int64, from: [BTCTransactionOutput]) ->
        (outs: [BTCTransactionOutput], selectedOutsAmount: BTCAmount)? {
        var neededOuts = [BTCTransactionOutput]()
        var total: BTCAmount = 0
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
            let lowerBound = String.Index(utf16Offset: charIndex, in: hexString)
            let upperBound = String.Index(utf16Offset: charIndex+2, in: hexString)
            
            let substring = hexString[lowerBound..<upperBound]
            reversedString += String(describing: substring.first!)
            reversedString += String(describing: substring.last!)
        }
        
        return reversedString
    }
}
