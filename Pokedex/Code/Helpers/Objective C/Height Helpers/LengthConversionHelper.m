//
//  LengthConversionHelper.m
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

#import "LengthConversionHelper.h"
#import "math.h"

@implementation LengthConversionHelper

static const float cm2ftConversionFactor = 30.48;
static const float ft2InchConversionFactor = 12.00;

- (float)convertCmToFeet: (float)cmLength {
    return cmLength/cm2ftConversionFactor;
}

- (float)convertFeetToCentimeters: (float)ftLength {
    return ftLength * cm2ftConversionFactor;
}

- (float)convertFeetToInches:(float)ftLength {
    return ftLength * ft2InchConversionFactor;
}

- (float)convertInchesToFeet:(float)inchLength {
    return inchLength / ft2InchConversionFactor;
}

- (NSString *)convertLengthToFormattedString: (float)length
                                      toUnit: (LengthUnit)unit
{
    NSString *unitString = @"";
    switch (unit) {
        case centimeters:
            unitString = @"cm";
            break;
            
        case feet:
            unitString = @"ft";
            break;
            
        case inches:
            unitString = @"in";
            break;
            
        default:
            // Unknown unit
            return nil;
    }
    
    // String is formatted to contain 2 trailing decimal places
    return [NSString stringWithFormat:@"%.2f %@", length, unitString];
}

/// Converts from your usual numeric format to the traditional format for feet 6'3" etc
- (NSString *)convertFeetToSpeciallyFormattedString: (float)ftLength {
    float totalInches = [self convertFeetToInches:(ftLength)];
    
    float remainingInches = fmodf(totalInches, ft2InchConversionFactor);
    
    /// i.e) 1.5 % 1 = 0.5, 1.5 - 0.5 = 1
    float remainingFeet =  ftLength - fmodf(ftLength, 1);
    
    // Only display floating points when needed
    if (fmodf(remainingInches, ft2InchConversionFactor) > 0) {
        return [NSString stringWithFormat:@"%.0f'%.2f\"", remainingFeet, remainingInches];
    }
    else {
        return [NSString stringWithFormat:@"%.0f'%.0f\"", remainingFeet, remainingInches];
    }
}

- (NSString *)convertCmToFeetFormattedString:(float)cmLength {
    float convertedLength = [self convertCmToFeet:(cmLength)];
    
    return [self
            convertLengthToFormattedString:convertedLength
            toUnit: feet];
}

- (NSString *)convertInchesToFeetFormattedString:(float)inchLength {
    float convertedLength = [self convertInchesToFeet:(inchLength)];
    
    return [self
            convertLengthToFormattedString:convertedLength
            toUnit: feet];
}

- (NSString *)convertFeetToInchesFormattedString:(float)ftLength {
    float convertedLength = [self convertFeetToInches:(ftLength)];
    
    return [self
            convertLengthToFormattedString:convertedLength
            toUnit: inches];
}

- (NSString *)convertFeetToCentimetersFormattedString:(float)ftLength {
    float convertedLength = [self convertFeetToCentimeters:(ftLength)];
    
    return [self
            convertLengthToFormattedString:convertedLength
            toUnit: centimeters];
}

@end
