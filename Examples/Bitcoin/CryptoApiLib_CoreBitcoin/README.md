# Using CryptoApiLib library with [CoreBitcoin](https://github.com/oleganza/CoreBitcoin)

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

### Constanst
The example has an `enum with constants` that can be modified with valid data to run the example.
```swift
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
```

### Generate address. Get outputs.
The following is an example that shows how to `generate address and obtain unspent outputs` for it using CryptoApiLib.
```swift
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
```

### Create Transaction
CryptoAPI allows you to send raw transactions, but before that you need to prepare it. As a result, you will get a transaction ready to be sent to the network.
`Creating a transaction` is as follows:
```swift
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
```

### Send Transaction
It remains only to `send` the transaction by sending a hash of the transaction using CryptoApi.
```swift
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
```

### Calculate fee for transaction
You can `calculate fee` for your transaction based on fee rate for kilobyte.
```swift
//firs of all, you need to get fee rate for kilobyte
var feePerKb: BTCAmount?
cryptoApi.btc.estimateFee { result in
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
