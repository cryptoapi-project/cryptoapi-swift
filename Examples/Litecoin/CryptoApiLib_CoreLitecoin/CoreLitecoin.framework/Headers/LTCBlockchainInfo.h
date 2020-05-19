// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>

// Collection of useful APIs for Blockchain.info
@interface LTCBlockchainInfo : NSObject

// Getting unspent outputs.

// Builds a request from a list of LTCAddress objects.
- (NSMutableURLRequest*) requestForUnspentOutputsWithAddresses:(NSArray*)addresses;
// List of LTCTransactionOutput instances parsed from the response.
- (NSArray*) unspentOutputsForResponseData:(NSData*)responseData error:(NSError**)errorOut;
// Makes sync request for unspent outputs and parses the outputs.
- (NSArray*) unspentOutputsWithAddresses:(NSArray*)addresses error:(NSError**)errorOut;


// Broadcasting transaction

// Request to broadcast a raw transaction data.
- (NSMutableURLRequest*) requestForTransactionBroadcastWithData:(NSData*)data;

@end

