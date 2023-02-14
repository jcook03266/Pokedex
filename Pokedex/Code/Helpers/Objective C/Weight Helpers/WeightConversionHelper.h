//
//  WeightConversionHelper.h
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface WeightConversionHelper : NSObject

// MARK: - Properties
/// kg to lbs conversion factor
@property (nonatomic, readonly) float kg2lbConversionFactor;

// MARK: - Utility Methods
- (float)convertKgToPounds: (float)kgWeight;
- (float)convertPoundsToKg: (float)lbWeight;

// MARK: - Supported Weight Units
typedef NS_ENUM(NSInteger, WeightUnit) {
    pounds,
    kilograms
};

// MARK: - To String
/// General Formatted String
- (NSString *)convertWeightToFormattedString: (float)weight
                                     toUnit: (WeightUnit)unit;

/// Specific formatted strings
- (NSString *)convertKgToPoundsFormattedString: (float)weight;

- (NSString *)convertPoundsToKgFormattedString: (float)weight;

@end

NS_ASSUME_NONNULL_END
