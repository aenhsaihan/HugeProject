//
//  ViewController.m
//  HugeProject
//
//  Created by Aditya Narayan on 5/9/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int previousCurrencyTotal;
    int postCurrencyTotal;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    previousCurrencyTotal = 1;
    postCurrencyTotal = 0;
    
    
    self.previousCurrencyTextField.delegate = self;
    self.postCurrencyTextField.delegate = self;
    
    self.previousCurrencyTextField.text = [NSString stringWithFormat:@"%d", previousCurrencyTotal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)previousCurrencyDecrement:(id)sender {
    
    if (previousCurrencyTotal == 0) {
        return;
    }
    
    self.previousCurrencyTextField.text = [NSString stringWithFormat:@"%d", --previousCurrencyTotal];
    
    NSLog(@"previousCurrencyTotal: %d", previousCurrencyTotal);
}

- (IBAction)previousCurrencyIncrement:(id)sender {
    
    self.previousCurrencyTextField.text = [NSString stringWithFormat:@"%d", ++previousCurrencyTotal];
    
    NSLog(@"previousCurrencyTotal: %d", previousCurrencyTotal);
}

- (IBAction)previousCurrencySelector:(id)sender {
}

- (IBAction)postCurrencyDecrement:(id)sender {
    
    if (postCurrencyTotal == 0) {
        return;
    }
    
    self.postCurrencyTextField.text = [NSString stringWithFormat:@"%d", --postCurrencyTotal];
    
    NSLog(@"postCurrencyTotal: %d", postCurrencyTotal);
    
}

- (IBAction)postCurrencyIncrement:(id)sender {
    
    self.postCurrencyTextField.text = [NSString stringWithFormat:@"%d", ++postCurrencyTotal];
    
    NSLog(@"postCurrencyTotal: %d", postCurrencyTotal);
    
}

- (IBAction)postCurrencySelector:(id)sender {
}

- (IBAction)tabulateCurrencies:(id)sender {
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}




@end
