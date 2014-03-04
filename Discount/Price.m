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
    // Calculate the discounted price
    int discountedAmount = (int) (self.price * self.discount / 100.0);
    int taxAmount        = (int) (self.price * self.tax / 100.0);
    int additionalDiscountAmount = (int) (self.price * self.additionalDiscount / 100.0);
    
    int discountPrice = (self.price - discountedAmount - self.centsOff - additionalDiscountAmount) + taxAmount;
    
    return (discountPrice > 0) ? discountPrice : 0;
}

- (int) originalPrice
{
    return self.price + (int) (self.price * (self.tax / 100.0));
}

// Convert (float) dollars to (int) cents
+ (int) centsFromDollars:(float)dollars
{
    return [[NSNumber numberWithFloat:roundf(dollars * 100.0)] intValue];
}

// Convert (int) cents to (float) dollars
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

// Shortened money format: http://stackoverflow.com/questions/11993806/convert-int-to-shortened-formatted-string
+ (NSString *)shortenedMoneyFormat:(unsigned long long)value
{
    NSUInteger index = 0;
    double dvalue = (double)value;

    NSArray *suffix = @[@"", @"K", @"M", @"B", @"T", @"P", @"E"];
    
    while ((value/=1000) && ++index) dvalue /= 1000;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];

    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-us"]];
    
    //Set fractional digits to 0 or 1
    [formatter setMaximumFractionDigits:(int)(dvalue < 100.0 && ((unsigned)((dvalue - (unsigned)dvalue) * 10) > 0))];
    
    return [[formatter stringFromNumber:[NSNumber numberWithFloat:dvalue]]
                        stringByAppendingString:[suffix objectAtIndex:index]];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Price: %d, cents off: %d, discount: %f, additional discount: %f, tax: %f, discount price: %d, original price: %d", self.price, self.centsOff, self.discount, self.additionalDiscount, self.tax, [self discountPrice], [self originalPrice]];
}
@end
