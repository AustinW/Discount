//
//  Price.m
//  Discount
//
//  Created by Austin White on 2/18/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "Price.h"

@implementation Price

@synthesize price, dollarsOff, discount, additionalDiscount, tax, discountPrice, originalPrice;

- (float) discountPrice
{
    return 0.0;
}

- (float) originalPrice
{
    return 0.0;
}

+ (Price *) mainPrice
{
    return self;
}
@end
