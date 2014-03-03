//
//  ViewController.m
//  Discount
//
//  Created by Austin White on 2/18/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "DiscountViewController.h"
#import "GraphViewController.h"

@interface DiscountViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtPrice;
@property (strong, nonatomic) IBOutlet UITextField *txtDollarsOff;
@property (strong, nonatomic) IBOutlet UITextField *txtDiscount;
@property (strong, nonatomic) IBOutlet UITextField *txtAdditionalDiscount;
@property (strong, nonatomic) IBOutlet UITextField *txtTax;
@property (strong, nonatomic) IBOutlet UILabel *lblOriginalPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblDiscountPrice;
@property (strong, nonatomic) NSArray *allTextFields;

@property (strong) Price *priceModel;

- (IBAction)calculate:(UIButton *)sender;

@end

@implementation DiscountViewController

@synthesize txtPrice, txtDollarsOff, txtDiscount, txtAdditionalDiscount, txtTax, lblOriginalPrice, lblDiscountPrice, priceModel;

- (void)touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
    NSLog( @"resigning first responder for inputTextField; Touch event!" );
    
    if ( ! [self isFirstResponder]) {
        [self closeKeyboard];
    }
}

#define _ABS( x ) ((x) < (0) ? (-x) : (x))
#define NUM_TEXTFIELDS 5

- (BOOL) textFieldShouldReturn:(UITextField *) textField {
    
    NSLog(@"Calculate!");
    
    [self closeKeyboard];
    
    [self calculate:nil];
    
    return YES;
    
}

- (BOOL)textFieldShouldBeginEditing: (UITextField *) textField
{
    NSLog(@"Right before");
    NSUInteger tag = textField.tag;
    NSUInteger nextTag = (tag + 1) % NUM_TEXTFIELDS;
    NSUInteger prevTag = (tag != 0) ? (_ABS((tag - 1))) % NUM_TEXTFIELDS : NUM_TEXTFIELDS - 1;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar sizeToFit];
    
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Previous"
                                   style: UIBarButtonItemStyleDone
                                   target: self
                                   action:@selector(txtNavClicked:)];
    prevButton.tag = prevTag;
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Next"
                                   style: UIBarButtonItemStyleDone
                                   target: self
                                   action:@selector(txtNavClicked:)];
    nextButton.tag = nextTag;
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                   target: self
                                   action: nil];
    
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                  target: self
                                  action: @selector(doneClicked:)];
    doneButton.tag = tag;
    
    NSArray* itemsArray = @[prevButton, nextButton, flexButton, doneButton];
    
    [toolbar setItems: itemsArray];
    
    [textField setInputAccessoryView: toolbar];
    
    return YES;
}

- (void)txtNavClicked: (UIBarButtonItem*) sender
{
    NSInteger tag = sender.tag;
    
    switch (tag) {
        case 0:
            [txtPrice becomeFirstResponder]; break;
        case 1:
            [txtDollarsOff becomeFirstResponder]; break;
        case 2:
            [txtDiscount becomeFirstResponder]; break;
        case 3:
            [txtAdditionalDiscount becomeFirstResponder]; break;
        case 4:
            [txtTax becomeFirstResponder]; break;
        default:
            break;
    }
}

- (void) doneClicked: (UIBarButtonItem*) sender
{
    NSLog( @"done pressed resigning first respond for inputTextField; Touch event!" );
    
    [self closeKeyboard];
}

- (void) closeKeyboard
{
    NSLog(@"Closing keyboard...");
    
    for (UITextField *txtField in self.allTextFields) {
        if ([txtField isFirstResponder]) {
            [txtField resignFirstResponder];
        };
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.priceModel = [Price priceModel];
    
    self.allTextFields = @[self.txtPrice, self.txtDollarsOff, self.txtDiscount, self.txtAdditionalDiscount, self.txtTax];
}

- (void) assignTxtFieldsToModel
{
    self.priceModel.price              = [Price centsFromDollars:[self.txtPrice.text floatValue]];
    self.priceModel.centsOff           = [Price centsFromDollars:[self.txtDollarsOff.text floatValue]];
    self.priceModel.discount           = [self.txtDiscount.text floatValue];
    self.priceModel.additionalDiscount = [self.txtAdditionalDiscount.text floatValue];
    self.priceModel.tax                = [self.txtTax.text floatValue];
}

- (NSString *) convertToDecimalString:(NSString *)txtFieldString
{
    return [NSString stringWithFormat:@"%.2f", [[NSDecimalNumber decimalNumberWithString:txtFieldString] floatValue]];
}

- (IBAction)calculate:(UIButton *)sender {
    
    if ([self.txtPrice.text isEqualToString:@""]) {
        self.txtPrice.text = @"0.00";
    } else {
        self.txtPrice.text = [self convertToDecimalString:self.txtPrice.text];
    }
    
    if ([self.txtDollarsOff.text isEqualToString:@""]) {
        self.txtDollarsOff.text = @"0.00";
    } else {
        self.txtDollarsOff.text = [self convertToDecimalString:self.txtDollarsOff.text];
    }
    
    if ([self.txtDiscount.text isEqualToString:@""]) {
        self.txtDiscount.text = @"0";
    }
    
    if ([self.txtAdditionalDiscount.text isEqualToString:@""]) {
        self.txtAdditionalDiscount.text = @"0";
    } else {
        self.txtAdditionalDiscount.text = [self convertToDecimalString:self.txtAdditionalDiscount.text];
    }
    
    if ([self.txtTax.text isEqualToString:@""]) {
        self.txtTax.text = @"0";
    }
    
    [self assignTxtFieldsToModel];
    
    self.lblOriginalPrice.text = [NSString stringWithFormat:@"$%.2f", [Price dollarsFromCents:[self.priceModel originalPrice]]];
    
    NSLog(@"Discount cents: %d", [self.priceModel discountPrice]);
    
    self.lblDiscountPrice.text = [@"$" stringByAppendingString:[NSString stringWithFormat:@"%.2f", [Price dollarsFromCents:self.priceModel.discountPrice]]];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showGraphSegue"]) {
        GraphViewController *graphViewController = (GraphViewController *) segue.destinationViewController;
        
        NSLog(@"Price model: %d", self.priceModel.price);
        // Pass the price model to the other view controller
        graphViewController.price = self.priceModel;
    }
}
@end
