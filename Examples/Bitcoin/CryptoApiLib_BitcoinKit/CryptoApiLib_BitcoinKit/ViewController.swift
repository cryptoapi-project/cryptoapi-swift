//
//  ViewController.swift
//  CryptoApiLib_BitcoinKit
//
//  Created by Artemy Markovsky on 2/27/20.
//  Copyright © 2020 pixelplex. All rights reserved.
//

import UIKit
import BitcoinKit
import CryptoApiLib

enum ExampleConstants {
    static let authToken = "Your token"
    
    static let changeAddress = "sender address"
    static let toAddress = "recipient address"
    static let sendAmount = 2300
    
    static let btcToSatoshiRound: Double = 10000000
}

class ViewController: UIViewController {
    
    func configCryptoApiLib() -> CryptoAPI {
        // Initialize setting for CryptoApi with your authorization token.
        let settings = Settings(authorizationToken: ExampleConstants.authToken) { configurator in
            configurator.networkType = NetworkType.testnet
            configurator.debugEnabled = true
        }
        let cryptoApi = CryptoAPI(settings: settings)
        
        return cryptoApi
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Config
        // setup CryptoApi library
        let cryptoApi = configCryptoApiLib()
        
        // setup BitcoinKit library
        var internalIndex: UInt32 {
            set {
                UserDefaults.standard.set(Int(newValue), forKey: #function)
            }
            get {
                return UInt32(UserDefaults.standard.integer(forKey: #function))
            }
        }
        var externalIndex: UInt32 {
            set {
                UserDefaults.standard.set(Int(newValue), forKey: #function)
            }
            get {
                return UInt32(UserDefaults.standard.integer(forKey: #function))
            }
        }
        let network = Network.testnetBTC
        
        // MARK: Generate address
        
        let mnemonic = try! Mnemonic.generate()
        let seed = try! Mnemonic.seed(mnemonic: mnemonic)
        let wallet = HDWallet(seed: seed, externalIndex: externalIndex, internalIndex: internalIndex, network: network)
        let privateKey = HDPrivateKey(seed: seed, network: .testnetBTC)
        
        // MARK: Get outputs
        // get address unspent outputs for balance calculating or transaction building
        var responseOutputs: [BTCAddressOutputResponseModel]?
        cryptoApi.btc.addressesOutputs(
            addresses: [wallet.address.legacy],
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
        
        // MARK: Get fee per kilobyte
        var feePerKb: String?
        //var feePerKb: Int64?
        cryptoApi.btc.feePerKb { result in
            switch result {
            case .success(let feeString):
                // response has result like "0.00001". Convert it to satoshi if necessary.
                    //let feeSatoshi = Double(feeString)! * ExampleConstants.btcToSatoshiRound
                    //feePerKb = Int64(feeSatoshi)
                feePerKb = feeString
            case .failure(let error):
                print(error)
            }
        }
        
        // MARK: Build transaction
        
        // define transaction details
        let toAddress = try! BitcoinAddress(legacy: ExampleConstants.toAddress)
        let changeAddress = try! BitcoinAddress(legacy: ExampleConstants.changeAddress)
        let amount = Int64(ExampleConstants.sendAmount)
        let fee: Int64 = 10000
        
        // convert CryptoApi BTCAddressOutputResponse models to BitcoinKit UnspentTransaction objects
        let outputs = mapResponseOutputs(model: responseOutputs!)
        
        let totalAmount: Int64 = Int64(outputs.reduce(0) { $0 + $1.output.value })
        let change: Int64 = totalAmount - amount - fee
        
        let toPubKeyHash: Data = toAddress.data
        let changePubkeyHash: Data = changeAddress.data
        
        let lockingScriptTo = Script.buildPublicKeyHashOut(pubKeyHash: toPubKeyHash)
        let lockingScriptChange = Script.buildPublicKeyHashOut(pubKeyHash: changePubkeyHash)
        
        let toOutput = TransactionOutput(value: UInt64(amount), lockingScript: lockingScriptTo)
        let changeOutput = TransactionOutput(value: UInt64(change), lockingScript: lockingScriptChange)
        
        let unsignedInputs = outputs.map { TransactionInput(previousOutput: $0.outpoint, signatureScript: Data(), sequence: UInt32.max) }
        let tx = Transaction(version: 1, inputs: unsignedInputs, outputs: [toOutput, changeOutput], lockTime: 0)
        
        var inputsToSign = tx.inputs
        
        // signing transaction
        let hashType = SighashType.BTC.ALL
        for (i, output) in tx.outputs.enumerated() {
            let signatureHelper = BTCSignatureHashHelper(hashType: SighashType.BTC.ALL)
            
            let sighash: Data = signatureHelper.createSignatureHash(of: tx, for: output, inputIndex: i)
            let signature: Data = try! Crypto.sign(sighash, privateKey: privateKey.privateKey())
            let txin = inputsToSign[i]
            let pubkey = privateKey.privateKey().publicKey()
            
            let unlockingScript = Script.buildPublicKeyUnlockingScript(signature: signature, pubkey: pubkey, hashType: hashType)
            
            inputsToSign[i] = TransactionInput(previousOutput: txin.previousOutput,
                                               signatureScript: unlockingScript,
                                               sequence: txin.sequence)
        }
        
        // MARK: Send transaction
        // get a transaction hex and send it with CryptoApi
        let transactionHex = tx.txHash.hex
        cryptoApi.btc.sendRaw(transaction: transactionHex) { result in
            switch result {
            case .success(let response):
                print(response.result)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController {
    func mapResponseOutputs(model: [BTCAddressOutputResponseModel])  -> [UnspentTransaction] {
        var outputs = [UnspentTransaction]()
        
        for item in model {
            let value = Int64(item.value)
            let address = try! BitcoinAddress(legacy: item.address)
            let lockScript = Script.buildPublicKeyHashOut(pubKeyHash: address.data)
            let txHash = Data(hex: item.mintTransactionHash.invertHex())!
            let txIndex = UInt32(item.mintIndex)
            
            let unspentOutput = TransactionOutput(value: UInt64(value), lockingScript: lockScript)
            let unspentOutpoint = TransactionOutPoint(hash: txHash, index: txIndex)
            let utxo = UnspentTransaction(output: unspentOutput, outpoint: unspentOutpoint)
            outputs.append(utxo)
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

extension Data {
    init?(hex: String) {
        let len = hex.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hex.index(hex.startIndex, offsetBy: i * 2)
            let k = hex.index(j, offsetBy: 2)
            let bytes = hex[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
    
    var hex: String {
        return reduce("") { $0 + String(format: "%02x", $1) }
    }
}
