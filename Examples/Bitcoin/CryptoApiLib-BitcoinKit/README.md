# Using CryptoApiLib library with [BitcoinKit](https://github.com/yenom/BitcoinKit)

### Get started

Сonfigure and return the object of the CryptoAPI class, which will allow to perform all the operations provided by the CryptoApiLib library.
Further, we can use the obtained method to get the CryptoAPI object anywhere in the program.
```swift
func configCryptoApiLib() -> CryptoAPI {
    // Initialize setting for CryptoApi with your authorization token.
    let apiSettings = Settings(authorizationToken: ExampleConstants.authToken) { configurator in
        configurator.networkType = NetworkType.testnet
    }
    let cryptoApi = CryptoAPI(settings: apiSettings)
    
    return cryptoApi
}
```
### Constants
The example has an `enum with constants` that can be modified with valid data to run the example.

```swift
enum ExampleConstants {
    static let authToken = "Your token"
    
    static let changeAddress = "sender address"
    static let toAddress = "recipient address"
    static let sendAmount = 2300
    
    static let btcToSatoshiRound: Double = 10000000
}
```
### Initialization of library objects
Initialize the necessary variables for working with libraries.
```swift
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
```
### Generate address. Get outputs.
The following is an example that shows how to `generate address and obtain unspent outputs` for it using CryptoApiLib.
```swift
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
```
### Obtain fee rate per kilobyte with CryptoApi
CryptoAPI can help you obtain fee rate per kilobyte like this:
```swift
var feePerKb: String?
//var feePerKb: Int64?
cryptoApi.btc.estimateFee { result in
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
```
### Create Transaction
CryptoAPI allows you to send raw transactions, but before that you need to prepare it. As a result, you will get a transaction ready to be sent to the network.
`Creating a transaction` is as follows:
```swift
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
```
### Send Transaction
It remains only to send the transaction by sending a hash of the transaction using CryptoApi.
```swift
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
```

## License

The MIT License (MIT)

Copyright (c) 2019 PixelPlex Inc. <https://pixelplex.io>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
