//
//  Price.h
//  Discount
//
//  Created by Austin White on 2/18/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <Foundation/Foundation.h>

// Singleton
@interface Price : NSObject

@property NSDecimalNumber *price;
@property NSDecimalNumber *dollarsOff;
@property NSDecimalNumber *discount;
@property NSDecimalNumber *additionalDiscount;
@property NSDecimalNumber *tax;

@property (readonly) NSDecimalNumber *discountPrice;
@property (readonly) NSDecimalNumber *originalPrice;

- (NSDecimalNumber *) discountPrice;
- (NSDecimalNumber *) originalPrice;

+ (Price *) priceModel;

@end