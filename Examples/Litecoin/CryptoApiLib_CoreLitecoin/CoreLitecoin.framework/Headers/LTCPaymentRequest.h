// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>
#import "LTCUnitsAndLimits.h"

// Interface to BIP70 payment protocol.
// Spec: https://github.com/bitcoin/bips/blob/master/bip-0070.mediawiki
//
// * LTCPaymentProtocol implements high-level request and response API.
// * LTCPaymentRequest object that represents "PaymentRequest" as described in BIP70.
// * LTCPaymentDetails object that represents "PaymentDetails" as described in BIP70.
// * LTCPayment object that represents "Payment" as described in BIP70.
// * LTCPaymentACK object that represents "PaymentACK" as described in BIP70.

extern NSInteger const LTCPaymentRequestVersion1;
extern NSInteger const LTCPaymentRequestVersionOpenAssets1;

extern NSString* __nonnull const LTCPaymentRequestPKITypeNone;
extern NSString* __nonnull const LTCPaymentRequestPKITypeX509SHA1;
extern NSString* __nonnull const LTCPaymentRequestPKITypeX509SHA256;

// Special value indicating that amount on the output is not specified.
extern LTCAmount const LTCUnspecifiedPaymentAmount;

// Status allows to correctly display information about security of the request to the user.
typedef NS_ENUM(NSInteger, LTCPaymentRequestStatus) {
    // Payment request is valid and the user can trust it.
    LTCPaymentRequestStatusValid                 = 0, // signed with a valid and known certificate.

    LTCPaymentRequestStatusNotCompatible         = 100, // version is not supported (currently only v1 is supported)

    // These allow Payment Request to be accepted with a warning to the user.
    LTCPaymentRequestStatusUnsigned              = 101, // PKI type is "none"
    LTCPaymentRequestStatusUnknown               = 102, // PKI type is unknown (for forward compatibility may allow sending or warn to upgrade).

    // These generally mean we should decline the Payment Request.
    LTCPaymentRequestStatusExpired               = 201,
    LTCPaymentRequestStatusInvalidSignature      = 202,
    LTCPaymentRequestStatusMissingCertificate    = 203,
    LTCPaymentRequestStatusUntrustedCertificate  = 204,
};

@class LTCNetwork;
@class LTCPayment;
@class LTCPaymentACK;
@class LTCPaymentRequest;
@class LTCPaymentDetails;
@class LTCTransaction;

NSArray* __nullable LTCParseCertificatesFromPaymentRequestPKIData(NSData* __nullable pkiData);

BOOL LTCPaymentRequestVerifySignature(NSString* __nullable pkiType,
                                             NSData* __nullable dataToVerify,
                                             NSArray* __nullable certificates,
                                             NSData* __nullable signature,
                                             LTCPaymentRequestStatus* __nullable statusOut,
                                             NSString* __autoreleasing __nullable *  __nullable signerOut);

// Payment requests are split into two messages to support future extensibility.
// The bulk of the information is contained in the PaymentDetails message.
// It is wrapped inside a PaymentRequest message, which contains meta-information
// about the merchant and a digital signature.
// message PaymentRequest {
//     optional uint32 payment_details_version = 1 [default = 1];
//     optional string pki_type = 2 [default = "none"];
//     optional bytes pki_data = 3;
//     required bytes serialized_payment_details = 4;
//     optional bytes signature = 5;
// }
@interface LTCPaymentRequest : NSObject

// Version of the payment request and payment details.
// Default is LTCPaymentRequestVersion1.
@property(nonatomic, readonly) NSInteger version;

// Public-key infrastructure (PKI) system being used to identify the merchant.
// All implementation should support "none", "x509+sha256" and "x509+sha1".
// See LTCPaymentRequestPKIType* constants.
@property(nonatomic, readonly, nonnull) NSString* pkiType;

// PKI-system data that identifies the merchant and can be used to create a digital signature.
// In the case of X.509 certificates, pki_data contains one or more X.509 certificates.
// Depends on pkiType. Optional.
@property(nonatomic, readonly, nullable) NSData* pkiData;

// A LTCPaymentDetails object.
@property(nonatomic, readonly, nonnull) LTCPaymentDetails* details;

// Digital signature over a hash of the protocol buffer serialized variation of
// the PaymentRequest message, with all serialized fields serialized in numerical order
// (all current protocol buffer implementations serialize fields in numerical order) and
// signed using the private key that corresponds to the public key in pki_data.
// Optional fields that are not set are not serialized (however, setting a field to its default value will cause it to be serialized and will affect the signature).
// Before serialization, the signature field must be set to an empty value so that
// the field is included in the signed PaymentRequest hash but contains no data.
@property(nonatomic, readonly, nullable) NSData* signature;

// Array of DER encoded certificates or nil if pkiType does offer certificates.
// This list is extracted from raw `pkiData`.
// If set, certificates are cerialized in X509Certificates object and set to pkiData.
@property(nonatomic, readonly, nonnull) NSArray* certificates;

// A date against which the payment request is being validated.
// If nil, system date at the moment of validation is used.
@property(nonatomic, nullable) NSDate* currentDate;

// Returns YES if payment request is correctly signed by a trusted certificate if needed
// and expiration date is valid.
// Accessing this property also updates `status` and `signerName`.
@property(nonatomic, readonly) BOOL isValid;

// Human-readable name of the signer or nil if it's unsigned.
// You should display this to the user as a name of the merchant.
// Accessing this property also updates `status` and `isValid`.
@property(nonatomic, readonly, nullable) NSString* signerName;

// Validation status.
// Accessing this property also updates `commonName` and `isValid`.
@property(nonatomic, readonly) LTCPaymentRequestStatus status;

// Binary serialization in protocol buffer format.
@property(nonatomic, readonly, nonnull) NSData* data;

- (nullable id) initWithData:(nullable NSData*)data;

- (nullable LTCPayment*) paymentWithTransaction:(nullable LTCTransaction*)tx;

- (nullable LTCPayment*) paymentWithTransactions:(nullable  NSArray*)txs memo:(nullable NSString*)memo;

@end

@interface LTCPaymentDetails : NSObject

// Mainnet or testnet. Default is mainnet.
@property(nonatomic, readonly, nonnull) LTCNetwork* network;

// Array of transaction outputs storing `value` in satoshis and `script` where payment should be sent.
// Unspecified amounts are set to LTC_MAX_MONEY so you can know if zero amount was actually specified (e.g. for OP_RETURN or proof-of-burn etc).
@property(nonatomic, readonly, nonnull) NSArray* /*[LTCTransactionOutput]*/ outputs;

// Array of transaction inputs storing `previousHash` and `previousIndex`.
// Client should include these inputs in the transaction as they constitute product offered by the merchant.
@property(nonatomic, readonly, nonnull) NSArray* /*[LTCTransactionInput]*/ inputs;

// Date when the PaymentRequest was created.
@property(nonatomic, readonly, nonnull) NSDate* date;

// Date after which the PaymentRequest should be considered invalid.
@property(nonatomic, readonly, nullable) NSDate* expirationDate;

// Plain-text (no formatting) note that should be displayed to the customer, explaining what this PaymentRequest is for.
@property(nonatomic, readonly, nullable) NSString* memo;

// Secure location (usually https) where a Payment message (see below) may be sent to obtain a PaymentACK.
// The payment_url specified in the PaymentDetails should remain valid at least until the PaymentDetails expires
// (or as long as possible if the PaymentDetails does not expire).
// Note that this is irrespective of any state change in the underlying payment request;
// for example cancellation of an order should not invalidate the payment_url,
// as it is important that the merchant's server can record mis-payments in order to refund the payment.
@property(nonatomic, readonly, nullable) NSURL* paymentURL;

// Arbitrary data that may be used by the merchant to identify the PaymentRequest.
// May be omitted if the merchant does not need to associate Payments with PaymentRequest or
// if they associate each PaymentRequest with a separate payment address.
@property(nonatomic, readonly, nullable) NSData* merchantData;

// Binary serialization in protocol buffer format.
@property(nonatomic, readonly, nonnull) NSData* data;

- (nullable id) initWithData:(nullable NSData*)data;

@end

// Payment messages are sent after the customer has authorized payment.
@interface LTCPayment : NSObject

// Should be copied from PaymentDetails.merchant_data.
// Merchants may use invoice numbers or any other data they require
// to match Payments to PaymentRequests.
@property(nonatomic, readonly, nullable) NSData* merchantData;

// One or more valid, signed Bitcoin transactions that fully pay the PaymentRequest
@property(nonatomic, readonly, nonnull) NSArray* /*[LTCTransaction]*/ transactions;

// Output scripts and amounts. Amounts are optional and can be zero.
@property(nonatomic, readonly, nonnull) NSArray* /*[LTCTransactionOutput]*/ refundOutputs;

// Plain-text note from the customer to the merchant.
@property(nonatomic, readonly, nullable) NSString* memo;

// Binary serialization in protocol buffer format.
@property(nonatomic, readonly, nonnull) NSData* data;

- (nullable id) initWithData:(nullable NSData*)data;

@end

// PaymentACK is the final message in the payment protocol;
// it is sent from the merchant's server to the bitcoin wallet in response to a Payment message.
@interface LTCPaymentACK : NSObject

// Copy of the Payment message that triggered this PaymentACK.
// Clients may ignore this if they implement another way of associating Payments with PaymentACKs.
@property(nonatomic, readonly, nonnull) LTCPayment* payment;

// Note that should be displayed to the customer giving the status of the transaction
// (e.g. "Payment of 1 LTC for eleven tribbles accepted for processing.")
@property(nonatomic, readonly, nullable) NSString* memo;

// Binary serialization in protocol buffer format.
@property(nonatomic, readonly, nonnull) NSData* data;

- (nullable id) initWithData:(nullable NSData*)data;

@end
