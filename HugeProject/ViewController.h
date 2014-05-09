//
//  ViewController.h
//  HugeProject
//
//  Created by Aditya Narayan on 5/9/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *previousCurrencyTextField;
@property (weak, nonatomic) IBOutlet UIButton *previousCurrencyDecrementer;
@property (weak, nonatomic) IBOutlet UIButton *previousCurrencyIncrementer;
@property (weak, nonatomic) IBOutlet UIButton *previousCurrencyButton;


@property (weak, nonatomic) IBOutlet UITextField *postCurrencyTextField;
@property (weak, nonatomic) IBOutlet UIButton *postCurrencyDecrementer;
@property (weak, nonatomic) IBOutlet UIButton *postCurrencyIncrementer;
@property (weak, nonatomic) IBOutlet UIButton *postCurrencyButton;


@property (weak, nonatomic) IBOutlet UIButton *tabulateButton;

@end
