//
//  GraphPartial.m
//  Discount
//
//  Created by Austin White on 2/28/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "GraphPartial.h"

@implementation GraphPartial

#pragma mark - Properties

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    // Draw in the background color
    if (self.color) {
        [self.color setFill];
        UIRectFill(self.bounds);
    }
}

#pragma mark - Initialization
- (void) setup
{
    // Setup initial settings for drawing
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

@end
