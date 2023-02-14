//
//  LengthConversionHelper.h
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LengthConversionHelper : NSObject

/// Centimeters in a foot
@property (nonatomic, readonly) float cm2ftConversionFactor;
/// Inches in a foot
@property (nonatomic, readonly) float ft2InchConversionFactor;

// MARK: - Utility Methods [Instance aka non-static]
- (float)convertCmToFeet: (float)cmLength;
- (float)convertFeetToCentimeters: (float)ftLength;
- (float)convertFeetToInches: (float)ftLength;
- (float)convertInchesToFeet: (float)inchLength;

// MARK: - Supported Weight Units
typedef NS_ENUM(NSInteger, LengthUnit) {
    centimeters,
    feet,
    inches
};

// MARK: - To String
/// General Formatted String
- (NSString *)convertLengthToFormattedString: (float)length
                                     toUnit: (LengthUnit)unit;

- (NSString *)convertFeetToSpeciallyFormattedString: (float)ftLength;

/// Specific formatted strings
- (NSString *)convertCmToFeetFormattedString: (float)cmLength;

- (NSString *)convertInchesToFeetFormattedString: (float)inchLength;

- (NSString *)convertFeetToInchesFormattedString: (float)ftLength;

- (NSString *)convertFeetToCentimetersFormattedString: (float)ftLength;

@end

NS_ASSUME_NONNULL_END
