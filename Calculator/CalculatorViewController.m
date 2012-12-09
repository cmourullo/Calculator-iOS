//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Ali Lemus on 6/28/12.
//  Copyright (c) 2012 Elemental Geeks. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfTypingANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize logDisplay = _logDisplay;
@synthesize userIsInTheMiddleOfTypingANumber = _userIsInTheMiddleOfTypingANumber;
@synthesize brain = _brain;

-(CalculatorBrain *)brain{
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    //NSLog(@"presiono: %@", digit);
    
    // llenar el display
    if (self.userIsInTheMiddleOfTypingANumber) {
        // digit == "." && el display ya tiene un punto -> no haga nada
        NSRange range = [self.display.text rangeOfString:@"."];
        if (!([digit isEqualToString:@"."] && (range.location != NSNotFound))){
            self.display.text =  [self.display.text stringByAppendingString:digit];  
        }
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfTypingANumber = YES;
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.logDisplay.text = [self.logDisplay.text stringByAppendingFormat:@" %@", self.display.text];
    self.userIsInTheMiddleOfTypingANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender {
    if(self.userIsInTheMiddleOfTypingANumber)[self enterPressed];
    double result = [self.brain performOperation:[sender currentTitle]];
    NSString *resultText = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultText;
    self.logDisplay.text = [self.logDisplay.text stringByAppendingFormat:@" %@ =%@", sender.currentTitle, resultText];
}

- (IBAction)controlPressed:(UIButton *)sender {
    if ([[sender currentTitle] isEqualToString:@"C"]) {
        [self.brain clearStack];
        self.display.text = @"";
        self.logDisplay.text = @"";
    } else if (self.userIsInTheMiddleOfTypingANumber){
        if ([[sender currentTitle] isEqualToString:@"⇦"]){
            NSString *displayText = self.display.text;
            displayText = [displayText substringToIndex:[displayText length] -1];
            if ([displayText length]) self.display.text = displayText;
            else {
                self.display.text = @"0";
                self.userIsInTheMiddleOfTypingANumber = NO;
            }
        }  
        if ([[sender currentTitle] isEqualToString:@"+/-"]) {
            double displayValue = [self.display.text doubleValue];
            displayValue *= -1;
            self.display.text = [NSString stringWithFormat:@"%g", displayValue];
        }
    } else if ([[sender currentTitle] isEqualToString:@"+/-"]){
        [self operationPressed:sender];
    }
}


- (void)viewDidUnload {
    [self setLogDisplay:nil];
    [super viewDidUnload];
}
@end
