//
//  TimeStringTests.m
//  VandyRecCenter
//
//  Created by Aaron Smith on 10/30/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TimeString.h"

@interface TimeStringTests : XCTestCase

@end

@implementation TimeStringTests

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

- (void) testTimeRangeBetweenTime
{
    TimeString* time1 = [[TimeString alloc] initWithString:@"8:00am"];
    TimeString* time2 = [[TimeString alloc] initWithString:@"10:00am"];
    NSLog(@"time1 time2: %f", [TimeString timeRangeBetweenTime:time1 andTime:time2]);
    XCTAssert([TimeString timeRangeBetweenTime:time1 andTime:time2] == 7200, @"timeRangeBetweenTime returns positive number of seconds difference if andTime: (time2) is after time1");
    TimeString* time3 = [[TimeString alloc] initWithString:@"6:00am"];
    NSLog(@"time1 time3: %f", [TimeString timeRangeBetweenTime:time1 andTime:time3]);
    XCTAssert([TimeString timeRangeBetweenTime:time1 andTime:time3] == -7200, @"timeRangeBetweenTime returns negative number of seconds difference if andTime: (time3) is before time1");
    XCTAssert([TimeString timeRangeBetweenTime:time2 andTime:time2] == 0, @"timeRangeBetweenTime returns 0 if passed the same time");
}

@end
