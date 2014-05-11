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
    
    UITextField *activeField;
    CGSize kbSize;
    
    NSArray *currencies;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    previousCurrencyTotal = 1;
    
    currencies = @[@"EUR", @"GBP", @"JPY", @"BRL"];
    
    self.previousCurrencyTextField.delegate = self;
    
    self.previousCurrencyTextField.text = [NSString stringWithFormat:@"%d", previousCurrencyTotal];
    
    
    [self convertAllCurrencies];
    
    
    
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
    
    [self convertAllCurrencies];
    
    NSLog(@"previousCurrencyTotal: %d", previousCurrencyTotal);
}

- (IBAction)previousCurrencyIncrement:(id)sender {
    
    self.previousCurrencyTextField.text = [NSString stringWithFormat:@"%d", ++previousCurrencyTotal];
    
    [self convertAllCurrencies];
    
    NSLog(@"previousCurrencyTotal: %d", previousCurrencyTotal);
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.previousCurrencyTextField.text intValue] < 0) {
        
        self.previousCurrencyTextField.text = [NSString stringWithFormat:@"%d", previousCurrencyTotal];
        return;
        
    }
    
    previousCurrencyTotal = [self.previousCurrencyTextField.text intValue];
    
    [self convertAllCurrencies];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.phase == UITouchPhaseBegan) {
        [self.previousCurrencyTextField resignFirstResponder];
    }
    
}

-(void)retrieveExchangeRate:(NSString *)currency delegate:(id)delegate callback:(SEL)callback
{
    NSString *url = [NSString stringWithFormat:@"http://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20yahoo.finance.xchange%%20where%%20pair%%20in%%20(%%22USD%@%%22)&format=json&env=store://datatables.org/alltableswithkeys&callback=", currency];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        NSLog(@"%@", dataStr);
        
        
        NSError *jsonError;
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *query = jsonDictionary[@"query"];
        NSDictionary *results = query[@"results"];
        NSDictionary *rate = results[@"rate"];
        
        NSLog(@"Rate: %@", rate[@"Rate"]);
        
        id rateObject = rate[@"Rate"];
        
        NSDictionary *resultSet = [[NSDictionary alloc] initWithObjectsAndKeys:rateObject, currency, nil];
        
        [delegate performSelector:callback withObject:resultSet];
        
    }];
    
}

-(void)retrieveExchangeResult:(id)resultDictionary
{
    NSString *currency = [[resultDictionary allKeys] objectAtIndex:0];
    
    float rate = [resultDictionary[currency] floatValue];
    
    if ([currency isEqualToString:@"EUR"]) {

        [self animateScrollingForLabel:self.eurosNumberLabel];
        
        self.eurosNumberLabel.text = [NSString stringWithFormat:@"%.02f", previousCurrencyTotal * rate];
        
    } else if ([currency isEqualToString:@"GBP"]) {
        
        [self animateScrollingForLabel:self.sterlingNumberLabel];
        
        self.sterlingNumberLabel.text = [NSString stringWithFormat:@"%.02f", previousCurrencyTotal * rate];
        
    } else if ([currency isEqualToString:@"JPY"]) {
        
        [self animateScrollingForLabel:self.yenNumbersLabel];
        
        self.yenNumbersLabel.text = [NSString stringWithFormat:@"%.02f", previousCurrencyTotal * rate];
        
    } else if ([currency isEqualToString:@"BRL"]) {
        
        [self animateScrollingForLabel:self.realNumbersLabel];
        
        self.realNumbersLabel.text = [NSString stringWithFormat:@"%.02f", previousCurrencyTotal * rate];
        
    } else {
        
        NSLog(@"Error: A certain currency could not be updated: %@", currency);
    }
}

-(void)convertAllCurrencies
{
    for (NSString *currency in currencies) {
        
        [self retrieveExchangeRate:currency delegate:self callback:@selector(retrieveExchangeResult:)];
        
    }
}

-(void)animateScrollingForLabel:(UILabel *)label
{
    // Add transition (must be called after myLabel has been displayed)
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;   //You can change this to any other duration
    animation.type = kCATransitionMoveIn;     //I would assume this is what you want because you want to "animate up or down"
    animation.subtype = kCATransitionFromTop; //You can change this to kCATransitionFromBottom, kCATransitionFromLeft, or kCATransitionFromRight
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [label.layer addAnimation:animation forKey:@"changeTextTransition"];
}


@end
