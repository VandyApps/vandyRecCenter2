//
//  VandyRecCenterTests.m
//  VandyRecCenterTests
//
//  Created by Brendan McNamara on 10/3/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+MyArrayClass.h"
#import "NSDate+DateHelper.h"
#import "Hours.h"

@interface VandyRecCenterTests : XCTestCase

@end

@implementation VandyRecCenterTests

- (void) setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void) tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/* Test Array Category */

// What's up with this answer being 8070450532247929002?
-(void) testReduceBlock
{
    NSArray *myIntegerArray = @[@0, @1, @2, @3, @4];
    
    NSInteger integerArraySum = [myIntegerArray reduce:^NSInteger(NSInteger memo, id element, NSUInteger index) {
        return memo + (NSInteger)element;
    }];
    
    NSLog(@"My array thing: %lu",  integerArraySum);
    
    // Should be 10 but isn't... (8070450532247929002)
    XCTAssertTrue(integerArraySum == 10, @"Integer value should be sum of array items");
}

- (void) testFilterBlock
{
    NSArray *myStringArray = @[@"String 1", @"String 2"];
    NSArray *myIntegerArray = @[@1, @2, @3, @4, @5];
    
    // Test that array of strings can be filtered
    NSArray *filteredIntegerArray = [myIntegerArray filter:^BOOL(id element, NSUInteger index) {
        if ([element isEqual: @3]) {
            return TRUE;
        }
        return FALSE;
    }];
    
    XCTAssertTrue([filteredIntegerArray isEqual:@[@3]], @"Integer elements should be filtered correctly");
    
    NSArray *filteredStringArray = [myStringArray filter:^BOOL(id element, NSUInteger index) {
        if ([element isEqualToString:@"String 1"]) {
            return TRUE;
        }
        return FALSE;
    }];
    
    XCTAssertTrue([filteredStringArray isEqual:@[@"String 1"]], @"String elements should be filtered correctly");
    
}

- (void) testForEachBlock
{
    NSArray *myArray = @[@"String 1", @"String 2", @"String 3"];
    __block NSArray *newArray = @[];
    [myArray forEach:^BOOL(id element, NSUInteger index) {
        newArray = [newArray arrayByAddingObject:element];
        if ([element isEqualToString:@"String 2"]) {
            return FALSE;
        }
        return TRUE;
    }];
    
    XCTAssertTrue([newArray isEqual:@[@"String 1"]], @"Loop should quit when block returns false");
}

/* Test Date Category */


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

@end
