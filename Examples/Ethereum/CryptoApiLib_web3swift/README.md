# Using CryptoApiLib library with [web3swift](https://github.com/matter-labs/web3swift)


### Get started

Сonfigure and return the object of the CryptoAPI class, which will allow to perform all the operations provided by the CryptoApiLib library.
Further, we can use the obtained method to get the CryptoAPI object anywhere in the program.
```swift
func configCryptoApiLib() -> CryptoAPI {
    // Initialize CryptoApi setting with your authorization token.
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
    static let authToken = "Your authorization token"
    
    static let toAddress = "recipient address"
    static let sendAmount = "1000000000000000000"
    
    static let password = "keystore password"
    static let mnemonicsPassword = "mnemonic's password"
    static let mnemonicString = "mnemonic of your address"
}
```
### Generate address. Get balance.
The following is an example that shows how to `generated address and obtain balance` for it using CryptoApiLib.
```swift
let cryptoApi = configCryptoApiLib()

let mnemonicString = ExampleConstants.mnemonicString
let keystore = try! BIP32Keystore(mnemonics: mnemonicString,
                                  password: ExampleConstants.password,
                                  mnemonicsPassword: ExampleConstants.mnemonicsPassword,
                                  language: .english)!
let keystoreManager = KeystoreManager([keystore])
let web = web3(provider: InfuraProvider(.Rinkeby)!)
web.addKeystoreManager(keystoreManager)

let account = try! web.wallet.getAccounts().first!
let address = keystore.addresses!.first!.address
print("Address \(address)")

cryptoApi.eth.balance(addresses: [address]) { result in
    switch result {
    case .success(let addressesBalancesArray):
        for item in addressesBalancesArray {
            print("Balance \(item.balance)")
        }
        
    case .failure(let error):
        print(error)
    }
}
```
### Estimate nonce, gas price and gas limit
Now, before creating a transaction, you need to get a `gas estimate`.
```swift
cryptoApi.eth.estimateGas(fromAddress: address, toAddress: ExampleConstants.toAddress,
                          data: "", value: ExampleConstants.sendAmount) { result in
    switch result {
    case .success(let response):
        print("nonse: \(response.nonce), gas prise: \(response.gasPrice), estimate: \(response.estimateGas).")
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
let ethToAddress = EthereumAddress(ExampleConstants.toAddress)!
let intTransactionValue = BigUInt(ExampleConstants.sendAmount)!
let nonce = BigUInt(response.nonce)
let gasLimit = BigUInt(response.estimateGas)
let gasPrice = BigUInt(response.gasPrice)!

let v = BigUInt(0)
let r = BigUInt(0)
let s = BigUInt(0)

var transaction = EthereumTransaction(
    nonce: nonce, gasPrice: gasPrice,
    gasLimit: gasLimit, to: ethToAddress,
    value: intTransactionValue, data: Data(),
    v: v, r: r, s: s
)
transaction.UNSAFE_setChainID(BigUInt(4)) // "4" for Rinkeby provider

// sing the transaction
try! Web3Signer.signTX(transaction: &transaction, keystore: keystore, account: account, password: ExampleConstants.password)
let transactionHash = transaction.encode()!.toHexString()

cryptoApi.eth.sendRaw(transaction: "0x" + transactionHash) { result in
    switch result {
    case .success(let response):
        print(response.hash)
        
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
