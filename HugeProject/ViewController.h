//
//  ViewController.h
//  HugeProject
//
//  Created by Aditya Narayan on 5/9/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *previousCurrencyTextField;
@property (weak, nonatomic) IBOutlet UIButton *previousCurrencyDecrementer;
@property (weak, nonatomic) IBOutlet UIButton *previousCurrencyIncrementer;


@property (weak, nonatomic) IBOutlet UILabel *sterlingNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *eurosNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *yenNumbersLabel;
@property (weak, nonatomic) IBOutlet UILabel *realNumbersLabel;




- (IBAction)previousCurrencyDecrement:(id)sender;
- (IBAction)previousCurrencyIncrement:(id)sender;




@end
