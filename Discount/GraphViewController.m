//
//  GraphViewController.m
//  Discount
//
//  Created by Austin White on 2/28/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "GraphViewController.h"
#import "Price.h"

@interface GraphViewController ()

@property (strong, nonatomic) IBOutlet UILabel *lblTotalCost;
@end



@implementation GraphViewController

@synthesize lblTotalCost;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    lblTotalCost.text = [NSString stringWithFormat:@"$%.2f", [self.price originalPrice]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
