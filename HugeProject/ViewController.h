//
//  ViewController.h
//  HugeProject
//
//  Created by Aditya Narayan on 5/9/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userInputTextField;
@property (weak, nonatomic) IBOutlet UIButton *currencyDecrementer;
@property (weak, nonatomic) IBOutlet UIButton *currencyIncrementer;


@property (weak, nonatomic) IBOutlet UILabel *sterlingNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *eurosNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *yenNumbersLabel;
@property (weak, nonatomic) IBOutlet UILabel *realNumbersLabel;

@property (nonatomic) float sterlingRate;
@property (nonatomic) float euroRate;
@property (nonatomic) float yenRate;
@property (nonatomic) float realRate;

@property (nonatomic) int dollarsTotal;


- (IBAction)previousCurrencyDecrement:(id)sender;
- (IBAction)previousCurrencyIncrement:(id)sender;




@end
