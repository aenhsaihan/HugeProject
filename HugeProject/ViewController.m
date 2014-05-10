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
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    previousCurrencyTotal = 1;
    
    
    self.previousCurrencyTextField.delegate = self;
    
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




-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    float inputHeight = textField.frame.origin.y + textField.frame.size.height;
    
    if (inputHeight > (self.view.frame.size.height - kbSize.height)) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame;
            
            // move our subView to its new position
            frame = self.view.frame;
            
            //the +5 is added to provide a little buffer between the subview and the top of the keyboard
            
            frame.origin.y = -(inputHeight - (self.view.frame.size.height - kbSize.height) + 5);
            
            self.view.frame=frame;
            
        }];
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame;
        
        // move our subView to its new position
        frame=self.view.frame;
        frame.origin.y=0;
        self.view.frame=frame;
        
        
    }];
    
    previousCurrencyTotal = [self.previousCurrencyTextField.text intValue];
    
    [self retrieveExchangeRate:@"EUR" delegate:self callback:@selector(retrieveExchangeResult:)];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    
    NSDictionary *info = [notification userInfo];
    
    kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        CGRect frame;
//        
//        // move our subView to its new position
//        frame = self.view.frame;
//        
//        if (activeField == self.postCurrencyTextField) {
//            
//            frame.origin.y = -(activeField.frame.origin.y - kbSize.height);
//            
//        } else {
//            
//            return;
//            
//        }
//        
//        
//        self.view.frame = frame;
//        
//        
//    }];
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame;
        
        // move our subView to its new position
        frame=self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
        
        
    }];
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
    
    if ([currency isEqualToString:@"EUR"]) {
        
        float rate = [resultDictionary[currency] floatValue];
        
        self.eurosNumberLabel.text = [NSString stringWithFormat:@"%.02f", previousCurrencyTotal * rate];
    }
}

@end
