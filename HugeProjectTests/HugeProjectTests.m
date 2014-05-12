//
//  HugeProjectTests.m
//  HugeProjectTests
//
//  Created by Aditya Narayan on 5/9/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface HugeProjectTests : XCTestCase

@end

@implementation HugeProjectTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testForZeroDollars
{
    ViewController *currencyConverter = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    
}

@end
