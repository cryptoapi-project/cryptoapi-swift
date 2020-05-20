// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>
#include <CoreLitecoin/openssl/ec.h>

// Represents a point on the elliptic curve secp256k1.
// Combined with LTCBigNumber arithmetic, you can do usual EC operations to manipulate private and public keys.
// Private key is a big integer (represented by raw NSData or LTCBigNumber).
// Public key is a point on the curve represented by LTCCurvePoint or LTCKey.
// LTCCurvePoint is mutable. There is no immutable counterpart.
@class LTCKey;
@class LTCBigNumber;
@interface LTCCurvePoint : NSObject <NSCopying>

// Serialized form of a curve point as a compressed public key (32-byte X coordinate with 1-byte prefix)
@property(nonatomic, readonly) NSData* data;

// Underlying data structure in OpenSSL.
@property(nonatomic, readonly) const EC_POINT* EC_POINT;

// Returns YES if the point is at infinity.
@property(nonatomic, readonly) BOOL isInfinity;

// Coordinates of the point
@property(nonatomic, readonly) LTCBigNumber* x;
@property(nonatomic, readonly) LTCBigNumber* y;

// Returns the generator point. Same as [LTCCurvePoint alloc] init].
+ (instancetype) generator;

// Returns order of the secp256k1 curve (FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141).
+ (LTCBigNumber*) curveOrder;

// Initializes point with its binary representation (corresponds to -data).
- (id) initWithData:(NSData*)data;

// Initializes point with OpenSSL EC_POINT.
- (id) initWithEC_POINT:(const EC_POINT*)ecpoint;

// These modify the receiver and return self (or nil in case of error). To create another point use -copy: [[point copy] multiply:number]
- (instancetype) multiply:(LTCBigNumber*)number;
- (instancetype) add:(LTCCurvePoint*)point;

// Efficiently adds n*G to the receiver. Equivalent to [point add:[[G copy] multiply:number]]
- (instancetype) addGeneratorMultipliedBy:(LTCBigNumber*)number;

// Re-declared `-copy` to provide exact return type.
- (LTCCurvePoint*) copy;

// Clears internal point data.
- (void) clear;



@end
