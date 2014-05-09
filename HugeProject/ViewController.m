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
    
    self.previousCurrencyTextField.text = [NSString stringWithFormat:@"%d", previousCurrencyTotal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)previousCurrencyDecrement:(id)sender {
}

- (IBAction)previousCurrencyIncrement:(id)sender {
}

- (IBAction)previousCurrencySelector:(id)sender {
}

- (IBAction)postCurrencyDecrement:(id)sender {
}

- (IBAction)postCurrencyIncrement:(id)sender {
}

- (IBAction)postCurrencySelector:(id)sender {
}

- (IBAction)tabulateCurrencies:(id)sender {
}
@end
