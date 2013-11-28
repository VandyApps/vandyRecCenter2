//
//  ArrayCategoryTests.m
//  VandyRecCenter
//
//  Created by Aaron Smith on 10/30/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+MyArrayClass.h"

@interface ArrayCategoryTests : XCTestCase

@end

@implementation ArrayCategoryTests

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

// What's up with this answer being 8070450532247929002?
-(void) testReduceBlock
{
    NSArray *myIntegerArray = @[@0, @1, @2, @3, @4];
    
    NSInteger integerArraySum = [myIntegerArray reduce:^NSInteger(NSInteger memo, id element, NSUInteger index) {
        return memo + (NSInteger)element;
    }];
    
    
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


@end
