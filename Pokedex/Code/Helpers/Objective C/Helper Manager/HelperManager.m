//
//  HelperManager.m
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

#import "HelperManager.h"

/// An object that encapsulates various helpers and converters 
@implementation HelperManager

WeightConversionHelper *weightConverter;
LengthConversionHelper *lengthConverter;

- (instancetype)init {
    self.weightConverter = [[WeightConversionHelper alloc] init];
    self.lengthConverter = [[LengthConversionHelper alloc] init];
    
    return self;
}

@end
