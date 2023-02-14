//
//  WeightConversionHelper.m
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

#import "WeightConversionHelper.h"

/// A general helper class that converts from one weight unit to another and prints out a corresponding formatted string
@implementation WeightConversionHelper

static const float kg2lbConversionFactor = 0.453592;

- (float)convertKgToPounds: (float)kgWeight {
    return kgWeight/kg2lbConversionFactor;
}

- (float)convertPoundsToKg: (float)lbWeight {
    return lbWeight * kg2lbConversionFactor;
}

- (NSString *)convertWeightToFormattedString:(float)weight
                                      toUnit:(WeightUnit)unit
{
    NSString *unitString = @"";
    switch (unit) {
        case pounds:
            unitString = @"lbs";
            break;
            
        case kilograms:
            unitString = @"kg";
            break;
        default:
            // Unknown unit
            return nil;
    }
    
    // String is formatted to contain 2 trailing decimal places
    return [NSString stringWithFormat:@"%.2f %@", weight, unitString];
}

- (NSString *)convertKgToPoundsFormattedString:(float)weight {
    float convertedWeight = [self convertKgToPounds:(weight)];
    
    return [self
            convertWeightToFormattedString:convertedWeight
            toUnit: pounds];
}

- (NSString *)convertPoundsToKgFormattedString:(float)weight {
    float convertedWeight = [self convertPoundsToKg:(weight)];
    
    return [self
            convertWeightToFormattedString:convertedWeight
            toUnit: kilograms];
}

@end
