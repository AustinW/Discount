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
- (IBAction)calculate:(UIButton *)sender;

@end

@implementation ViewController

@synthesize txtPrice, txtDollarsOff, txtDiscount, txtAdditionalDiscount, txtTax, lblOriginalPrice, lblDiscountPrice;

- (void)touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
    NSLog( @"resigning first responder for inputTextField; Touch event!" );
    
    NSArray *textFields = @[self.txtPrice, self.txtDollarsOff, self.txtDiscount, self.txtAdditionalDiscount, self.txtTax];
    
    if ( ! [self isFirstResponder]) {
        for (UITextField *txtField in textFields) {
            if ([txtField isFirstResponder]) {
                [txtField resignFirstResponder];
            };
        }
    }
}

#define _ABS( x ) ((x) < (0) ? (-x) : (x))
#define NUM_TEXTFIELDS 5

- (BOOL) textFieldShouldReturn:(UITextField *) textField {
    
    NSLog(@"Calculate!");
    
    
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
                                   action:@selector(previousClicked:)];
    prevButton.tag = prevTag;
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Next"
                                   style: UIBarButtonItemStyleDone
                                   target: self
                                   action:@selector(nextClicked:)];
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

//- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
//    
//    UITextField *next = theTextField.nextTextField;
//    if (next) {
//        [next becomeFirstResponder];
//    } else {
//        [theTextField resignFirstResponder];
//    }
//    
//    return NO;
//}

- (void)nextClicked: (UIBarButtonItem*) sender
{
    NSLog(@"Next clicked");
    
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

- (void)previousClicked: (UIBarButtonItem*) sender
{
    NSLog(@"Previous clicked");
    
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
    
    NSArray *textFields = @[self.txtPrice, self.txtDollarsOff, self.txtDiscount, self.txtAdditionalDiscount, self.txtTax];
    
    if ( ! [self isFirstResponder]) {
        for (UITextField *txtField in textFields) {
            if ([txtField isFirstResponder]) {
                [txtField resignFirstResponder];
            };
        }
    }
}

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

- (IBAction)calculate:(UIButton *)sender {
}
@end
