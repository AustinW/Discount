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

@synthesize price, centsOff, discount, additionalDiscount, tax;

- (int) discountPrice
{
    int discountedAmount = (int) (self.price * self.discount / 100.0);
    int taxAmount        = (int) (self.price * self.tax / 100.0);
    int additionalDiscountAmount = (int) (self.price * self.additionalDiscount / 100.0);
    
    return (self.price - discountedAmount - self.centsOff - additionalDiscountAmount) + taxAmount;
}

- (int) originalPrice
{
    return self.price + (int) (self.price * (self.tax / 100.0));
}

+ (int) centsFromDollars:(float)dollars
{
    return [[NSNumber numberWithFloat:roundf(dollars * 100.0)] intValue];
}

+ (float) dollarsFromCents:(int)cents
{
    return (cents % 100 == 0) ? cents / 100.0 : floorf(cents / 100.0) + ((cents % 100) / 100.0);
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

+ (NSString *)shortenedMoneyFormat:(float)value
{
    NSUInteger index = 0;
    NSArray *suffix = @[@"", @"K", @"M", @"B", @"T", @"P", @"E"];
    
    while ((value /= 1000) && ++index) value /= 1000;
    
    return [NSString stringWithFormat:@"%@%@", [NSNumber numberWithFloat:value], [suffix objectAtIndex:index]];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Price: %d, cents off: %d, discount: %f, additional discount: %f, tax: %f, discount price: %d, original price: %d", self.price, self.centsOff, self.discount, self.additionalDiscount, self.tax, [self discountPrice], [self originalPrice]];
}
@end
