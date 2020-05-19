// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>
#import "LTCData.h"

// This category is for user's convenience only.
// For documentation look into LTCData.h.
// If you link CoreLitecoin library without categories enabled, nothing will break.
// This is also used in unit tests in CoreLitecoin.
@interface NSData (LTCData)

// Core hash functions
- (NSData*) SHA1;
- (NSData*) SHA256;
- (NSData*) LTCHash256;  // SHA256(SHA256(self)) aka Hash or Hash256 in BitcoinQT

#if LTCDataRequiresOpenSSL
- (NSData*) RIPEMD160;
- (NSData*) LTCHash160; // RIPEMD160(SHA256(self)) aka Hash160 in BitcoinQT
#endif

// Formats data as a lowercase hex string
- (NSString*) hex;
- (NSString*) uppercaseHex;

- (NSString*) hexString DEPRECATED_ATTRIBUTE;
- (NSString*) hexUppercaseString DEPRECATED_ATTRIBUTE;


// Encrypts/decrypts data using the key.
// IV should either be nil or at least 128 bits long
+ (NSMutableData*) encryptData:(NSData*)data key:(NSData*)key iv:(NSData*)initializationVector;
+ (NSMutableData*) decryptData:(NSData*)data key:(NSData*)key iv:(NSData*)initializationVector;

@end
