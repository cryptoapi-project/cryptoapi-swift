# Using CryptoApiLib library with web3swift

The `source code` of the EthereumKit library you can find  by clicking on the [link](https://cocoapods.org/pods/web3swift)

### Start using

Сonfigure and return the object of the CryptoAPI class, which will allow to perform all the operations provided by the CryptoApiLib library.
```
func configCryptoApiLib() -> CryptoAPI {
    // Initialize setting for CryptoApi with your authorization token.
    let apiSettings = Settings(authorizationToken: "Your token") { configurator in
        configurator.networkType = NetworkType.testnet
    }
    let cryptoApi = CryptoAPI(settings: apiSettings)
    
    return cryptoApi
}
```
Further, we can use the obtained method to get the CryptoAPI object anywhere in the program.

The following is an example that shows how to `generated address and obtain balance` for it using CryptoApiLib.
```
let cryptoApi = configCryptoApiLib()
       
let mnemonicString = "your mnemonic words"

let keystore = try! BIP32Keystore(mnemonics: mnemonicString,
                                  password: "",
                                  mnemonicsPassword: "",
                                  language: .english)!
let keystoreManager = KeystoreManager([keystore])
let web = web3(provider: InfuraProvider(.Rinkeby)!)
web.addKeystoreManager(keystoreManager)

let account = try! web.wallet.getAccounts().first!
let address = keystore.addresses!.first!.address

cryptoApi.eth.balance(addresses: [address]) { result in
    switch result {
    case .success(let addressesBalancesArray):
        for item in addressesBalancesArray {
            print(item.balance)
        }
        
    case .failure(let error):
        print(error)
    }
}
```

Now, before creating a transaction, you need to get a `gas estimate`.
```
let toAddress = "to address"
let value = "10000"
var estimatedGas: ETHEstimateGasResponseModel?
cryptoApi.eth.estimateGas(fromAddress: address, toAddress: toAddress, data: "", value: value) { result in
    switch result {
    case .success(let response):
        estimatedGas = response
        print("nonse: \(response.nonce), gas prise: \(response.gasPrice), estimate: \(response.estimateGas).")
        return
    case .failure(let error):
        print(error)
        return
    }
}
```

CryptoAPI allows you to send raw transactions, but before that you need to prepare it.
`Creating and sending a transaction` is as follows:
```
guard let ethToAddress = EthereumAddress(toAddress) else {
    print("Invalid address")
    return
}

let nonce = BigUInt(fee.nonce)
let gasLimit = BigUInt(fee.estimateGas)
guard let intTransactionValue = BigUInt(value), let gasPrice = BigUInt(fee.gasPrice) else {
    return
}
let v = BigUInt(0)
let r = BigUInt(0)
let s = BigUInt(0)

// transaction creation
var transaction = EthereumTransaction(nonce: nonce, gasPrice: gasPrice, gasLimit: gasLimit, 
                                        to: ethToAddress, value: intTransactionValue, data: Data(), 
                                        v: v, 
                                        r: r, 
                                        s: s)
transaction.UNSAFE_setChainID(BigUInt(4)) // "4" for Rinkeby provider

// transaction signing
try! Web3Signer.signTX(transaction: &transaction, keystore: keystoreManager, account: account, password: "")
guard let transactionHash = transaction.encode()?.toHexString() else {
    return
}

// transaction sending
cryptoApi.eth.sendRaw(transaction: transactionHash) { result in
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
