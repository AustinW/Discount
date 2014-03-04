//
//  GraphViewController.m
//  Discount
//
//  Created by Austin White on 2/28/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "DiscountViewController.h"
#import "GraphViewController.h"
#import "Price.h"
#import "GraphPartial.h"

@interface GraphViewController ()
@property (strong, nonatomic) IBOutlet UIView *paidGraphSuperView;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalCost;
@end

@implementation GraphViewController

@synthesize lblTotalCost, paidGraphSuperView;

- (void)gotoDiscountView:(id)sender
{
    // Go back
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateDiscountGraphLabel:(GraphPartial *)discountAmountGraph withLabel:(UILabel *)discountLabel andPrice:(Price *)price
{
    // Perform some auto-layout manipulation to center the label within superview
    [discountLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    int discountAmount = [price originalPrice] - [price discountPrice];
    
    // Get a shortened version of the price if it's greater than 10,000
    NSString *priceString = [@"$" stringByAppendingString:[self priceRepresentation:discountAmount]];
    NSString *percentageString = [NSString stringWithFormat:@"%.1f", ((float) discountAmount / (float) [self.price originalPrice]) * 100.0];
    
    discountLabel.numberOfLines = 2;
    discountLabel.text          = [NSString stringWithFormat:@"%@\n%@%%", priceString, percentageString];
    discountLabel.font          = [UIFont fontWithName:@"Helvetica Neue-Light" size:19];
    
    // Add the label to the view
    [discountAmountGraph addSubview:discountLabel];
    
    // Center the label on screen within the discount graph view using autolayout programmatically
    // because the label and view are generated on the fly. Center on x and y coordinates
    NSLayoutConstraint *discountConstraint = [NSLayoutConstraint constraintWithItem:discountLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:discountAmountGraph attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [discountAmountGraph addConstraint:discountConstraint];
    
    discountConstraint = [NSLayoutConstraint constraintWithItem:discountLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:discountAmountGraph attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [discountAmountGraph addConstraint:discountConstraint];
}

- (NSString *)priceRepresentation:(int)value
{
    return (value >= 10000) ? [Price shortenedMoneyFormat:(unsigned long long)[Price dollarsFromCents:value]] : [NSString stringWithFormat:@"%.2f", [Price dollarsFromCents:value]];
}

- (void)updateAmountPaidGraphLabel:(GraphPartial *)amountPaidGraph withLabel:(UILabel *)amountLabel andPrice:(Price *)price
{
    // Perform some auto-layout manipulation to center the label within superview
    [amountLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // Get monetary amount with shorthand
    
    int amountPaid = [price discountPrice];
    
    NSString *priceString = [@"$" stringByAppendingString:[self priceRepresentation:amountPaid]];
    NSString *percentageString = [NSString stringWithFormat:@"%.1f", ((float) amountPaid / (float) [price originalPrice]) * 100.0];

    amountLabel.numberOfLines = 2;
    amountLabel.text          = [NSString stringWithFormat:@"%@\n%@%%", priceString, percentageString];
    amountLabel.textColor     = [UIColor whiteColor];
    amountLabel.font          = [UIFont fontWithName:@"Helvetica Neue-Light" size:19];

    // Add the label to the view
    [amountPaidGraph addSubview:amountLabel];
    
    // Center the label on screen within the discount graph view using autolayout programmatically
    // because the label and view are generated on the fly. Center on x and y coordinates
    NSLayoutConstraint *amountPaidConstraint = [NSLayoutConstraint constraintWithItem:amountLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:amountPaidGraph attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [amountPaidGraph addConstraint:amountPaidConstraint];
    
    amountPaidConstraint = [NSLayoutConstraint constraintWithItem:amountLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:amountPaidGraph attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    [amountPaidGraph addConstraint:amountPaidConstraint];
}

- (GraphPartial *)generateDiscountGraphView
{
    // Calculate the height needed for the discount view based on the amount the person is saving
    float discountAmountHeight = paidGraphSuperView.bounds.size.height * ([self.price originalPrice] - [self.price discountPrice]) / [self.price originalPrice];
    
    // Create the subview and init the frame within the superview's coordinate system
    GraphPartial *discountAmountGraph = [[GraphPartial alloc] initWithFrame:CGRectMake(paidGraphSuperView.bounds.origin.x, paidGraphSuperView.bounds.origin.y, paidGraphSuperView.bounds.size.width, discountAmountHeight)];
    
    // Set color of bar to a light green
    [discountAmountGraph setColor:[UIColor colorWithRed:168.0/255.0 green:1.0 blue:163.0/255.0 alpha:1.0]];
    
    [paidGraphSuperView addSubview:discountAmountGraph];
    
    return discountAmountGraph;
}

- (GraphPartial *)generateAmountPaidGraphViewBasedOnDiscountGraph:(GraphPartial *)discountAmountGraph
{
    // Calculate the height needed for the amount paid view based on the amount the person is paying
    float amountPaidHeight = paidGraphSuperView.bounds.size.height * ((float) [self.price discountPrice] / (float) [self.price originalPrice]);
    
    // Create the subview and init the frame within the superview's coordinate system
    GraphPartial *amountPaidGraph = [[GraphPartial alloc] initWithFrame:CGRectMake(paidGraphSuperView.bounds.origin.x, paidGraphSuperView.bounds.origin.y + discountAmountGraph.bounds.size.height, paidGraphSuperView.bounds.size.width, amountPaidHeight)];
    
    // Set color of bar to a light red
    [amountPaidGraph setColor:[UIColor colorWithRed:1.0 green:163.0/255.0 blue:165.0/255.0 alpha:1.0]];
    
    [paidGraphSuperView addSubview:amountPaidGraph];
    
    return amountPaidGraph;
}

// TODO: Separate out logic into separate isolated functions
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Loading graph view");
    
    // Get the total cost and display in the middle of the blue bar (uses autolayout in interface builder)
    lblTotalCost.text = [@"$" stringByAppendingString:[self priceRepresentation:[self.price originalPrice]]];
    
    // Generate the discount amount graph
    GraphPartial *discountAmountGraph = [self generateDiscountGraphView];
    
    UILabel *discountLabel = [[UILabel alloc] init];
    
    // Set the discount labels
    [self updateDiscountGraphLabel:discountAmountGraph withLabel:discountLabel andPrice:self.price];
    
    // Generate the amount paid graph
    GraphPartial *amountPaidGraph = [self generateAmountPaidGraphViewBasedOnDiscountGraph:discountAmountGraph];
    
    UILabel *amountLabel = [[UILabel alloc] init];
    
    // Set the amount paid labels
    [self updateAmountPaidGraphLabel:amountPaidGraph withLabel:amountLabel andPrice:self.price];
    
    [paidGraphSuperView addSubview:amountPaidGraph];
    
    // Register a swipe detector
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gotoDiscountView:)];
    
    swipeRight.numberOfTouchesRequired = 1;
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
}

@end
