// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>

@class LTCKey;

// Implementation of [ECIES](http://en.wikipedia.org/wiki/Integrated_Encryption_Scheme)
// compatible with [Bitcore ECIES](https://github.com/bitpay/bitcore-ecies) implementation.
@interface LTCEncryptedMessage : NSObject

// When encrypting, sender's keypair must contain a private key.
@property(nonatomic) LTCKey* senderKey;

// When decrypting, recipient's keypair must contain a private key.
@property(nonatomic) LTCKey* recipientKey;

- (NSData*) encrypt:(NSData*)plaintext;
- (NSData*) decrypt:(NSData*)ciphertext;

@end
