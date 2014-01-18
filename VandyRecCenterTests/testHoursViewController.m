//
//  testHoursViewController.m
//  VandyRecCenter
//
//  Created by Aaron Smith on 1/18/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HoursViewController.h"

@interface testHoursViewController : XCTestCase

@end

@implementation testHoursViewController

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testTimeIntervalStringValueWithHoursAndMinutes
{
    HoursViewController *controller = [[HoursViewController alloc] init];
    
    // Test hours == 0 and minutes > 1
    NSInteger hours = 0;
    NSInteger minutes = 30;
    XCTAssert([[controller timeIntervalStringValueWithHours:hours andMinutes:minutes] isEqualToString:@"30 minutes"], @"timeIntervalStringValue returns a string without hours when hours == 0");
    
    // Test hours == 1 and minutes == 0
    hours = 1;
    minutes = 0;
    XCTAssert([[controller timeIntervalStringValueWithHours:hours andMinutes:minutes] isEqualToString:@"1 hour 0 minutes"], @"timeIntervalStringValue returns a string with singular word 'hour' when hours == 1 and plural minutes when minutes == 0");
    
    // Test hours > 1 and minutes == 1
    hours = 5;
    minutes = 1;
    XCTAssert([[controller timeIntervalStringValueWithHours:hours andMinutes:minutes] isEqualToString:@"5 hours 1 minute"], @"timeIntervalStringValue returns a string with plural hours and 0 singular word 'minute when hours > 1 and minutes == 1");
    
}

@end
