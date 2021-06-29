# Using CryptoApiLib library with [EthereumKit](https://github.com/horizontalsystems/ethereum-kit-ios)

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

```swift
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
```

### Constanst
The example has an `enum with constants` that can be modified with valid data to run the example.
```swift
enum ExampleConstants {
    static let authToken = "Your token"
    
    static let fromAddress = "sender address"
    static let toAddress = "recipient address"
    static let sendAmount = "100000000000000"
    
    static let mnemonicHex = "000102030405060708090a0b0c0d0e0f"
    static let words = ["example","array", "of", "your", "brainkey", "words"]
}
```
### Generate address. Get balance.
The following is an example that shows how to `generated address and obtain balance` for it using CryptoApiLib.
```swift
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
```
### Estimate nonce, gas price and gas limit
Now, before creating a transaction, you need to get a `gas estimate`.
```swift
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
```
### Create and Send trantaction
CryptoAPI allows you to send raw transactions, but before that you need to prepare it.
`Creating and sending a transaction` is as follows:
```swift
let amount = BigUInt(stringLiteral: ExampleConstants.sendAmount)
let address = try! Address(hex: "0x73eb56f175916bd17b97379c1fdb5af1b6a82c84")

kit
    .sendSingle(address: address, value: amount, gasPrice: 50_000_000_000, gasLimit: 1_000_000_000_000)
    .subscribe(onSuccess: { transaction in
        print("Transcation hash: \(transaction.transaction.hash.hex)")
        comletion(transaction.transaction.hash.hex)
        // sendSingle returns FullTransaction object which contains transaction, receiptWithLogs and internalTransactions
    })

cryptoApi.eth.sendRaw(transaction: transactionHash) { result in
    switch result {
    case .success(let response):
        print(response.hash)
        return

    case .failure(let error):
        fatalError("Error: \(error.localizedDescription)")
    }
}
```


## License

The MIT License (MIT)

Copyright (c) 2021 PixelPlex Inc. <https://pixelplex.io>

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
