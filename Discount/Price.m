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

@synthesize price, centsOff, discount, additionalDiscount, tax, discountPrice = _discountPrice;

- (void) calculate
{
    int discountedAmount = [[NSNumber numberWithFloat:roundf(self.price * self.discount / 100.0)] intValue],
        taxAmount        = [[NSNumber numberWithFloat:roundf(self.price * self.tax / 100.0)] intValue];
    
    _discountPrice = (self.price - discountedAmount - self.centsOff - self.additionalDiscount) + taxAmount;
}

- (float) originalPrice
{
    return roundf((self.price + roundf(self.price * (self.tax / 100.0)) / 100.0));
}

+ (int) centsFromDollars:(float) dollars
{
    return [[NSNumber numberWithFloat:roundf(dollars * 100.0)] intValue];
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
