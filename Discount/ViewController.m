//
//  ViewController.m
//  Discount
//
//  Created by Austin White on 2/18/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtPrice;
@property (strong, nonatomic) IBOutlet UITextField *txtDollarsOff;
@property (strong, nonatomic) IBOutlet UITextField *txtDiscount;
@property (strong, nonatomic) IBOutlet UITextField *txtAdditionalDiscount;
@property (strong, nonatomic) IBOutlet UITextField *txtTax;
@property (strong, nonatomic) IBOutlet UILabel *lblOriginalPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblDiscountPrice;

@end

@implementation ViewController

@synthesize txtPrice, txtDollarsOff, txtDiscount, txtAdditionalDiscount, txtTax, lblOriginalPrice, lblDiscountPrice;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
