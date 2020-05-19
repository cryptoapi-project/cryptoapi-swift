// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import "LTCAddress.h"

@interface LTCAssetAddress : LTCAddress
@property(nonatomic, readonly, nonnull) LTCAddress* bitcoinAddress;
+ (nonnull instancetype) addressWithBitcoinAddress:(nonnull LTCAddress*)btcAddress;
@end
