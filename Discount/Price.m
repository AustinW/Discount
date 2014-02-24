//
//  Price.m
//  Discount
//
//  Created by Austin White on 2/18/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "Price.h"

@implementation Price

static Price *priceModel = nil;

@synthesize price, dollarsOff, discount, additionalDiscount, tax, discountPrice, originalPrice;

- (void) calculate
{
    
}

+ (Price *) priceModel
{
    @synchronized(self) {
        if (priceModel == nil) {
            priceModel = [[Price alloc] init];
        }
    }
    
    return priceModel;
}
@end
