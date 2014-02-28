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
@property int additionalDiscount;
@property float tax;

@property (readonly) int discountPrice;
@property (readonly) int originalPrice;

- (float) originalPrice;

- (void) calculate;

+ (int) centsFromDollars:(float) dollars;

+ (Price *) priceModel;

@end