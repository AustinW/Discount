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

@synthesize price, dollarsOff, discount, additionalDiscount, tax, discountPrice = _discountPrice, originalPrice;

- (void) calculate
{
    float discountedAmount = self.price * self.discount / 100,
          taxAmount        = self.price * self.tax / 100;
    
    _discountPrice = (self.price - discountedAmount - self.dollarsOff - self.additionalDiscount) + taxAmount;
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
