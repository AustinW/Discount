//
//  GraphViewController.m
//  Discount
//
//  Created by Austin White on 2/28/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "GraphViewController.h"
#import "Price.h"
#import "GraphPartial.h"

@interface GraphViewController ()
@property (strong, nonatomic) IBOutlet UIView *paidGraphSuperView;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalCost;
@end



@implementation GraphViewController

@synthesize lblTotalCost, paidGraphSuperView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// TODO: Separate out logic into separate isolated functions
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lblTotalCost.text = [NSString stringWithFormat:@"$%.2f", [Price dollarsFromCents:[self.price originalPrice]]];
    
    float discountAmountHeight = paidGraphSuperView.bounds.size.height * ([self.price originalPrice] - [self.price discountPrice]) / [self.price originalPrice];
    
    float amountPaidHeight = paidGraphSuperView.bounds.size.height * ((float) [self.price discountPrice] / (float) [self.price originalPrice]);
    
    GraphPartial *discountAmountGraph = [[GraphPartial alloc] initWithFrame:CGRectMake(paidGraphSuperView.bounds.origin.x, paidGraphSuperView.bounds.origin.y, paidGraphSuperView.bounds.size.width, discountAmountHeight)];
    
    [discountAmountGraph setColor:[UIColor colorWithRed:168.0/255.0 green:1.0 blue:163.0/255.0 alpha:1.0]];
    
    UILabel *discountLabel = [[UILabel alloc] init];
    [discountLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // Get monetary amount with shorthand
    discountLabel.text = @"$46.12";
    // Set label's font and color to match (Helvetica Neue Light)
    
    [paidGraphSuperView addSubview:discountAmountGraph];
    [discountAmountGraph addSubview:discountLabel];
    
    NSLayoutConstraint *discountConstraint = [NSLayoutConstraint constraintWithItem:discountLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:discountAmountGraph attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [discountAmountGraph addConstraint:discountConstraint];
    
    discountConstraint = [NSLayoutConstraint constraintWithItem:discountLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:discountAmountGraph attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [discountAmountGraph addConstraint:discountConstraint];
    
    GraphPartial *amountPaidGraph = [[GraphPartial alloc] initWithFrame:CGRectMake(paidGraphSuperView.bounds.origin.x, paidGraphSuperView.bounds.origin.y + discountAmountGraph.bounds.size.height, paidGraphSuperView.bounds.size.width, amountPaidHeight)];
    
    // Set color of bar
    [amountPaidGraph setColor:[UIColor colorWithRed:1.0 green:163.0/255.0 blue:165.0/255.0 alpha:1.0]];
    
    [paidGraphSuperView addSubview:amountPaidGraph];
    
}

@end
