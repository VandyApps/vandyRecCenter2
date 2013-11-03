//
//  HoursModelTests.m
//  VandyRecCenter
//
//  Created by Aaron Smith on 10/30/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Hours.h"

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
                                    @{@"startTime":@"05:30pm",
                                      @"endTime":@"09:00pm"},
                                    @{@"startTime":@"05:30pm",
                                      @"endTime":@"09:00pm"},
                                    @{@"startTime":@"05:30pm",
                                      @"endTime":@"09:00pm"},
                                    @{@"startTime":@"05:30pm",
                                      @"endTime":@"09:00pm"},
                                    @{@"startTime":@"05:30pm",
                                      @"endTime":@"09:00pm"},
                                    @{@"startTime":@"05:30pm",
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
    Hours* myHours = [[Hours alloc] init];
    NSArray* myArray = @[@{@"name": @"foo", @"thing1": @2}, @{@"name": @"bar", @"thing1": @3}, @{@"name": @"bar", @"thing1": @4}];
    
    [myHours setValue:myArray forKey:@"hours"]; // Hack; replace with initWithHours: method
    
    NSDictionary* correctResponse = @{@"name": @"bar", @"thing1": @3};
    NSDictionary* response = [myHours hoursWithTitle:@"bar"];
    
    XCTAssertTrue([response isEqualToDictionary:correctResponse], @"hoursWithTitle should return single hours entry");
}

- (void) testDefaultHours {
    Hours* myHours = [[Hours alloc] init];
    NSArray* myArray = @[@{@"name": @"foo", @"priorityNumber": @0}, @{@"name": @"bar", @"priorityNumber": @1}, @{@"name": @"han", @"priorityNumber": @0}];
    
    [myHours setValue:myArray forKey:@"hours"];
    
    NSArray* correctResponse = @[@{@"name": @"foo", @"priorityNumber": @0}, @{@"name": @"han", @"priorityNumber": @0}];
    NSArray* response = [myHours defaultHours];
    
    XCTAssertTrue([response isEqualToArray:correctResponse], @"defaultHours should return array of all entries with priority 0");
}

- (void) testFacilityHours {
    Hours* myHours = [[Hours alloc] init];
    NSArray* myArray = @[@{@"name": @"foo", @"facilityHours": @TRUE}, @{@"name": @"bar", @"facilityHours": @FALSE}];
    
    [myHours setValue:myArray forKey:@"hours"];
    
    NSArray* correctResponse = @[@{@"name": @"foo", @"facilityHours": @TRUE}];
    NSArray* response = [myHours facilityHours];
    
    XCTAssertTrue([response isEqualToArray:correctResponse], @"facilityHours should return array of all entries with facilityHours marked as 'true'");
}

- (void) testClosedHours {
    Hours* myHours = [[Hours alloc] init];
    NSArray* myArray = @[@{@"name": @"foo", @"closedHours": @TRUE}, @{@"name": @"bar", @"closedHours": @FALSE}];
    
    [myHours setValue:myArray forKey:@"hours"];
    
    NSArray *correctResponse = @[@{@"name": @"foo", @"closedHours": @TRUE}];
    NSArray *response = [myHours closedHours];
    
    XCTAssertTrue([response isEqualToArray:correctResponse], @"closedHours should return array of all entries with closedHours marked as 'true'");
}

- (void) testOtherHours {
    Hours* myHours = [[Hours alloc] init];
    [myHours setValue:hoursArray forKey:@"hours"];
    NSArray *correctResponse = @[@{@"name": @"bar", @"priorityNumber": @1,
                                   @"facilityHours": @FALSE, @"closedHours": @FALSE}];
    NSArray *response = [myHours otherHours];
    XCTAssertTrue([response isEqualToArray:correctResponse], @"otherHours should return array of all entries with closedHours == false, facilityHours == false, priorityNumber !=0");
}

- (void) testCurrentHours {
    Hours* myHours = [[Hours alloc] init];
    [myHours setValue:currentHoursArray forKey: @"hours"];
    
    NSDictionary *correctResponse = @{@"startTime":@"12:00pm",
                                 @"endTime":@"05:00pm"};
    NSDictionary *response = [myHours currentHours];
    NSLog(@"CurrentHours: %@", response);
    XCTAssertTrue([response isEqualToDictionary:correctResponse], @"currentHours should return dictionary of the Rec Center's current hours");
}

@end
