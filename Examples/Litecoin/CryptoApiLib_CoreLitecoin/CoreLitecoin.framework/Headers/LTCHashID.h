// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>

/*!
 * Converts string transaction or block ID (reversed tx hash in hex format) to binary hash.
 */
NSData* LTCHashFromID(NSString* identifier);

/*!
 * Converts hash of the transaction or block to its string ID (reversed hash in hex format).
 */
NSString* LTCIDFromHash(NSData* hash);
