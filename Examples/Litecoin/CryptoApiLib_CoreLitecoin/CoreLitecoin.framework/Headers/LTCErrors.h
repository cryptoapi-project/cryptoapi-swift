// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>

extern NSString* const LTCErrorDomain;

typedef NS_ENUM(NSUInteger, LTCErrorCode) {
    
    // Canonical pubkey/signature check errors
    LTCErrorNonCanonicalPublicKey            = 4001,
    LTCErrorNonCanonicalScriptSignature      = 4002,
    
    // Script verification errors
    LTCErrorScriptError                      = 5001,
    
    // LTCPriceSource errors
    LTCErrorUnsupportedCurrencyCode          = 6001,

    // BIP70 Payment Protocol errors
    LTCErrorPaymentRequestInvalidResponse    = 7001,
    LTCErrorPaymentRequestTooBig             = 7002,

    // Secret Sharing errors
    LTCErrorIncompatibleSecret               = 10001,
    LTCErrorInsufficientShares               = 10002,
    LTCErrorMalformedShare                   = 10003,
};
