//
//  HoursModelTests.m
//  VandyRecCenter
//
//  Created by Aaron Smith on 10/30/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Hours.h"
#import "TimeString.h"

@interface HoursModelTests : XCTestCase

@end

@implementation HoursModelTests

/* Declare variables that are accessible by all tests */
NSArray *hoursArray = nil;
NSArray *currentHoursArray = nil;

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    hoursArray = @[@{@"name": @"foo",
                     @"priorityNumber": @0,
                     @"facilityHours": @YES,
                     @"closedHours": @YES},
                   @{@"name": @"bar",
                     @"priorityNumber": @1,
                     @"facilityHours": @NO,
                     @"closedHours": @NO}
                   ];
    currentHoursArray = @[@{@"name":@"default hours",
                            @"startDate":@"05/01/2013",
                            @"endDate":@"12/01/2013",
                            @"facilityHours":@"true",
                            @"closedHours":@"false",
                            @"priorityNumber":@0,
                            @"times": @[
                                    @{@"startTime":@"12:00pm",
                                      @"endTime":@"05:00pm"},
                                    @{@"startTime":@"12:00am",
                                      @"endTime":@"09:00pm"},
                                    @{@"startTime":@"05:30am",
                                      @"endTime":@"09:00pm"},
                                    @{@"startTime":@"05:30am",
                                      @"endTime":@"09:00pm"},
                                    @{@"startTime":@"05:30am",
                                      @"endTime":@"09:00pm"},
                                    @{@"startTime":@"05:30am",
                                      @"endTime":@"09:00pm"},
                                    @{@"startTime":@"12:00pm",
                                      @"endTime":@"05:00pm"}
                                ]
                            }
                          ];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

/* Test Hours Model */

- (void) testHoursWithTitle
{
    NSArray* myArray = @[@{@"name": @"foo", @"thing1": @2}, @{@"name": @"bar", @"thing1": @3}, @{@"name": @"bar", @"thing1": @4}];
    
    Hours* myHours = [[Hours alloc] initWithHours:myArray];
    
    NSDictionary* correctResponse = @{@"name": @"bar", @"thing1": @3};
    NSDictionary* response = [myHours hoursWithTitle:@"bar"];
    
    XCTAssertTrue([response isEqualToDictionary:correctResponse], @"hoursWithTitle should return single hours entry");
}

- (void) testDefaultHours {
    NSArray* myArray = @[@{@"name": @"foo", @"priorityNumber": @0}, @{@"name": @"bar", @"priorityNumber": @1}, @{@"name": @"han", @"priorityNumber": @0}];
    
    Hours* myHours = [[Hours alloc] initWithHours:myArray];
    
    NSArray* correctResponse = @[@{@"name": @"foo", @"priorityNumber": @0}, @{@"name": @"han", @"priorityNumber": @0}];
    NSArray* response = [myHours defaultHours];
    
    XCTAssertTrue([response isEqualToArray:correctResponse], @"defaultHours should return array of all entries with priority 0");
}

- (void) testFacilityHours {
    NSArray* myArray = @[@{@"name": @"foo", @"facilityHours": @TRUE}, @{@"name": @"bar", @"facilityHours": @FALSE}];
    
    Hours* myHours = [[Hours alloc] initWithHours:myArray];
    
    NSArray* correctResponse = @[@{@"name": @"foo", @"facilityHours": @TRUE}];
    NSArray* response = [myHours facilityHours];
    
    XCTAssertTrue([response isEqualToArray:correctResponse], @"facilityHours should return array of all entries with facilityHours marked as 'true'");
}

- (void) testClosedHours {
    NSArray* myArray = @[@{@"name": @"foo", @"closedHours": @TRUE}, @{@"name": @"bar", @"closedHours": @FALSE}];
    
    Hours* myHours = [[Hours alloc] initWithHours:myArray];
    
    NSArray *correctResponse = @[@{@"name": @"foo", @"closedHours": @TRUE}];
    NSArray *response = [myHours closedHours];
    
    XCTAssertTrue([response isEqualToArray:correctResponse], @"closedHours should return array of all entries with closedHours marked as 'true'");
}

- (void) testOtherHours {
    Hours* myHours = [[Hours alloc] initWithHours:hoursArray];
    NSArray *correctResponse = @[@{@"name": @"bar", @"priorityNumber": @1,
                                   @"facilityHours": @FALSE, @"closedHours": @FALSE}];
    NSArray *response = [myHours otherHours];
    XCTAssertTrue([response isEqualToArray:correctResponse], @"otherHours should return array of all entries with closedHours == false, facilityHours == false, priorityNumber !=0");
}

// TODO: Fix this test (it fails due to the test, not the method)
- (void) testCurrentHours {
    Hours* myHours = [[Hours alloc] initWithHours:currentHoursArray];
    NSDate *today = [[NSDate alloc] init];
    NSLog(@"currentTime: %@", today);
    
    NSDictionary *correctResponse = @{@"startTime":@"05:30pm",
                                      @"endTime":@"09:00pm"};
    NSDictionary *response = [myHours currentHours];
    NSLog(@"CurrentHours: %@", response);
    XCTAssertTrue([response isEqualToDictionary:correctResponse], @"currentHours should return dictionary of the Rec Center's current hours");
}

- (void) testOpeningTime {
    Hours* myHours = [[Hours alloc] initWithHours:currentHoursArray];
    TimeString *correctResponse = [[TimeString alloc] initWithString:@"05:30pm"];
    TimeString *response = [myHours openingTime];
    XCTAssert([[response stringValue] isEqualToString:[correctResponse stringValue]], @"openingTime should return a TimeString of the Rec Center's current opening hours");
}

- (void) testClosedTime {
    Hours* myHours = [[Hours alloc] initWithHours:currentHoursArray];
    TimeString *correctResponse = [[TimeString alloc] initWithString:@"09:00pm"];
    TimeString *response = [myHours closedTime];
    XCTAssert([[response stringValue] isEqualToString:[correctResponse stringValue]], @"closedTime should retrun a TimeString of the Rec Center's current closing hours.");
}

// TODO: Fix code so that it adjusts for timezones because right now (at 12:30am) it is a whole day off
- (void) testIsOpen {
    Hours* myHours = [[Hours alloc] initWithHours:currentHoursArray];
    NSLog(@"openingTime: %@", [myHours openingTime]);
    XCTAssert([myHours isOpen] == TRUE, @"isOpen should return true if open and false if not open");
}

// TODO: Mock current time so tests will pass all the time
- (void) testWillOpenLaterToday {
    Hours* myHours = [[Hours alloc] initWithHours:currentHoursArray];
    XCTAssert([myHours willOpenLaterToday] == FALSE, @"willOpenLaterToday returns true if the opening time is later than the current time. Returns false if opening time has passed.");
}

// TODO: Same as above
- (void) testWasOpenEarlierToday {
    Hours* myHours = [[Hours alloc] initWithHours:currentHoursArray];
    XCTAssert([myHours wasOpenEarlierToday] == FALSE, @"wasOpenEarlierToday returns true if the closed time has passed.");
}

// TODO: Figure out how to get a consistent time interval to test...
- (void) testTimeUntilClosed {
    Hours* myHours = [[Hours alloc] initWithHours:currentHoursArray];
    NSLog(@"Time Until Closed: %f", [myHours timeUntilClosed]);
}

- (void) testTimeUntilOpen {
    Hours* myHours = [[Hours alloc] initWithHours:currentHoursArray];
    NSLog(@"Time Until Open: %f", [myHours timeUntilOpen]);
}

- (void) testParseForHoursHash {
    Hours *myHours = [[Hours alloc] init];
    [myHours parse:currentHoursArray];
    XCTAssert(currentHoursArray == myHours.hours, @"hours array on Hours object should be equal to the hours array that was parsed");
}

@end
