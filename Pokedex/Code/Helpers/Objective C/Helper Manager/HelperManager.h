//
//  HelperManager.h
//  Pokedex
//
//  Created by Justin Cook on 2/14/23.
//

#import <Foundation/Foundation.h>
#import "WeightConversionHelper.h"
#import "LengthConversionHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface HelperManager : NSObject

@property (nonatomic, strong) WeightConversionHelper *weightConverter;
@property (nonatomic, strong) LengthConversionHelper *lengthConverter;

@end

NS_ASSUME_NONNULL_END
