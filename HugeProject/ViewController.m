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
        [self.postCurrencyTextField resignFirstResponder];
    }
    
}

@end
