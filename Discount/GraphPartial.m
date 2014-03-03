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

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 5.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

- (void)drawRect:(CGRect)rect
{
    
    NSLog(@"Color: %@", self.color);
    
    if (self.color) {
        [self.color setFill];
        UIRectFill(self.bounds);
    }
}

- (void)drawCorners
{
    
}

#pragma mark - Initialization
- (void) setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    
//    [self setNeedsDisplay];
}

- (void)awakeFromNib
{
    [self setup];
}

@end
