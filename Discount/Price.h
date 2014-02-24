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

@property float price;
@property float dollarsOff;
@property float discount;
@property float additionalDiscount;
@property float tax;

@property (readonly) float discountPrice;
@property (readonly) float originalPrice;

- (float) discountPrice;
- (float) originalPrice;

- (void) calculate;

+ (Price *) priceModel;

@end