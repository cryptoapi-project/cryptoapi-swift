// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>
@class LTCAddress;

// Collection of APIs for Chain.con
@interface LTCChainCom : NSObject

- (id)initWithToken:(NSString *)token; // Free API Token from http://chain.com

// Getting unspent outputs.

// Builds a request from a list of LTCAddress objects.
- (NSMutableURLRequest*) requestForUnspentOutputsWithAddress:(LTCAddress*)address;
// List of LTCTransactionOutput instances parsed from the response.
- (NSArray*) unspentOutputsForResponseData:(NSData*)responseData error:(NSError**)errorOut;
// Makes sync request for unspent outputs and parses the outputs.
- (NSArray*) unspentOutputsWithAddress:(LTCAddress*)addresses error:(NSError**)errorOut;


// Broadcasting transaction

// Request to broadcast a raw transaction data.
- (NSMutableURLRequest*) requestForTransactionBroadcastWithData:(NSData*)data;

@end
