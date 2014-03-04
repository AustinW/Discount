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

@property int price;
@property int centsOff;
@property float discount;
@property float additionalDiscount;
@property float tax;

- (int) originalPrice;
- (int) discountPrice;

+ (int) centsFromDollars:(float) dollars;
+ (float) dollarsFromCents:(int) cents;

+ (NSString *)shortenedMoneyFormat:(unsigned long long)value;

+ (Price *) priceModel;

@end