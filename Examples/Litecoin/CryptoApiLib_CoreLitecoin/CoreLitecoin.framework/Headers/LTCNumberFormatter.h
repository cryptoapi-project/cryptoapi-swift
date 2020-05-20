// CoreBitcoin by Oleg Andreev <oleganza@gmail.com>, WTFPL.

#import <Foundation/Foundation.h>
#import "LTCUnitsAndLimits.h"

typedef NS_ENUM(NSInteger, LTCNumberFormatterUnit) {
    LTCNumberFormatterUnitSatoshi  = 0, // satoshis = 0.00000001 LTC
    LTCNumberFormatterUnitBit      = 2, // bits     = 0.000001 LTC
    LTCNumberFormatterUnitMilliLTC = 5, // mLTC     = 0.001 LTC
    LTCNumberFormatterUnitLTC      = 8, // LTC      = 100 million satoshis
};

typedef NS_ENUM(NSInteger, LTCNumberFormatterSymbolStyle) {
    LTCNumberFormatterSymbolStyleNone      = 0, // no suffix
    LTCNumberFormatterSymbolStyleCode      = 1, // suffix is LTC, mLTC, Bits or SAT
    LTCNumberFormatterSymbolStyleLowercase = 2, // suffix is btc, mbtc, bits or sat
    LTCNumberFormatterSymbolStyleSymbol    = 3, // suffix is Ƀ, mɃ, ƀ or ṡ
};

extern NSString* const LTCNumberFormatterBitcoinCode;    // XBT
extern NSString* const LTCNumberFormatterSymbolLTC;      // Ƀ
extern NSString* const LTCNumberFormatterSymbolMilliLTC; // mɃ
extern NSString* const LTCNumberFormatterSymbolBit;      // ƀ
extern NSString* const LTCNumberFormatterSymbolSatoshi;  // ṡ

/*!
 * Rounds the decimal number and returns its longLongValue.
 * Do not use NSDecimalNumber.longLongValue as it will return 0 on iOS 8.0.2 if the number is not rounded first.
 */
LTCAmount LTCAmountFromDecimalNumber(NSNumber* num);

@interface LTCNumberFormatter : NSNumberFormatter

/*!
 * Instantiates and configures number formatter with given unit and suffix style.
 */
- (id) initWithBitcoinUnit:(LTCNumberFormatterUnit)unit;
- (id) initWithBitcoinUnit:(LTCNumberFormatterUnit)unit symbolStyle:(LTCNumberFormatterSymbolStyle)symbolStyle;

/*!
 * Unit size to be displayed (regardless of how it is presented)
 */
@property(nonatomic) LTCNumberFormatterUnit bitcoinUnit;

/*!
 * Style of formatting the units regardless of the unit size.
 */
@property(nonatomic) LTCNumberFormatterSymbolStyle symbolStyle;

/*!
 * Placeholder text for the input field.
 * E.g. "0 000 000.00" for 'bits' and "0.00000000" for 'LTC'.
 */
@property(nonatomic, readonly) NSString* placeholderText;

/*!
 * Returns a matching bitcoin symbol.
 * If `symbolStyle` is LTCNumberFormatterSymbolStyleNone, returns the code (LTC, mLTC, Bits or SAT).
 */
@property(nonatomic, readonly) NSString* standaloneSymbol;

/*!
 * Returns a matching bitcoin unit code (LTC, mLTC etc) regardless of the symbol style.
 */
@property(nonatomic, readonly) NSString* unitCode;

/*!
 * Formats the amount according to units and current formatting style.
 */
- (NSString *) stringFromAmount:(LTCAmount)amount;

/*!
 * Returns 0 in case of failure to parse the string.
 * To handle that case, use `-[NSNumberFormatter numberFromString:]`, but keep in mind
 * that NSNumber* will be in specified units, not in satoshis.
 */
- (LTCAmount) amountFromString:(NSString *)string;

@end
