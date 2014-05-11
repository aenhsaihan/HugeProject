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
    int dollarTotal;
    
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
    
    //Initialize the amount to be converted with one dollar
    dollarTotal = 1;
    
    
    //You can manage the different currencies here
    currencies = @[@"EUR", @"GBP", @"JPY", @"BRL"];
    
    
    self.userInputTextField.delegate = self;
    self.userInputTextField.text = [NSString stringWithFormat:@"%d", dollarTotal];
    
    
    [self convertAllCurrencies];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)previousCurrencyDecrement:(id)sender {
    
    if (dollarTotal == 0) {
        return;
    }
    
    self.userInputTextField.text = [NSString stringWithFormat:@"%d", --dollarTotal];
    
    [self convertAllCurrencies];
    
}

- (IBAction)previousCurrencyIncrement:(id)sender {
    
    self.userInputTextField.text = [NSString stringWithFormat:@"%d", ++dollarTotal];
    
    [self convertAllCurrencies];
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.userInputTextField.text intValue] < 0) {
        
        self.userInputTextField.text = [NSString stringWithFormat:@"%d", dollarTotal];
        return;
        
    }
    
    dollarTotal = [self.userInputTextField.text intValue];
    
    [self convertAllCurrencies];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.phase == UITouchPhaseBegan) {
        [self.userInputTextField resignFirstResponder];
    }
    
}

-(void)retrieveExchangeRate:(NSString *)currency delegate:(id)delegate callback:(SEL)callback
{
    NSString *url = [NSString stringWithFormat:@"http://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20yahoo.finance.xchange%%20where%%20pair%%20in%%20(%%22USD%@%%22)&format=json&env=store://datatables.org/alltableswithkeys&callback=", currency];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        //Uncomment the following two lines if you would like to see the JSON string.
        //NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        //NSLog(@"%@", dataStr);
        
        if (connectionError) {
            
            NSLog(@"%@", [connectionError localizedDescription]);
            return;
            
        }
        
        
        NSError *jsonError;
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            
            NSLog(@"%@", [jsonError localizedDescription]);
            return;
        }
        
        //Drilling down into the JSON string to get our rate
        
        NSDictionary *query = jsonDictionary[@"query"];
        NSDictionary *results = query[@"results"];
        NSDictionary *rate = results[@"rate"];
        
        
        
        id rateObject = rate[@"Rate"];
        NSDictionary *resultSet = [[NSDictionary alloc] initWithObjectsAndKeys:rateObject, currency, nil];
        
        //We've got our rate, now perform conversion...
        
        [delegate performSelector:callback withObject:resultSet];
        
    }];
    
}

-(void)updateCurrencyLabels:(id)resultDictionary
{
    NSString *currency = [[resultDictionary allKeys] objectAtIndex:0];
    
    float rate = [resultDictionary[currency] floatValue];
    
    if ([currency isEqualToString:@"EUR"]) {

        [self animateScrollingForLabel:self.eurosNumberLabel];
        
        self.eurosNumberLabel.text = [NSString stringWithFormat:@"%.02f", dollarTotal * rate];
        
    } else if ([currency isEqualToString:@"GBP"]) {
        
        [self animateScrollingForLabel:self.sterlingNumberLabel];
        
        self.sterlingNumberLabel.text = [NSString stringWithFormat:@"%.02f", dollarTotal * rate];
        
    } else if ([currency isEqualToString:@"JPY"]) {
        
        [self animateScrollingForLabel:self.yenNumbersLabel];
        
        self.yenNumbersLabel.text = [NSString stringWithFormat:@"%.02f", dollarTotal * rate];
        
    } else if ([currency isEqualToString:@"BRL"]) {
        
        [self animateScrollingForLabel:self.realNumbersLabel];
        
        self.realNumbersLabel.text = [NSString stringWithFormat:@"%.02f", dollarTotal * rate];
        
    } else {
        
        NSLog(@"Error: A certain currency could not be updated: %@", currency);
    }
}

-(void)convertAllCurrencies
{
    for (NSString *currency in currencies) {
        
        [self retrieveExchangeRate:currency delegate:self callback:@selector(updateCurrencyLabels:)];
        
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
