//
//  VandyRecCenterTests.m
//  VandyRecCenterTests
//
//  Created by Brendan McNamara on 10/3/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+MyArrayClass.h"

@interface VandyRecCenterTests : XCTestCase

@end

@implementation VandyRecCenterTests

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

- (void)testExample
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    
}

//-(void)testReduceBlock
//{
//    NSArray *myStringArray = @[@"String 1", @"String 2"];
//    NSArray *myIntegerArray = @[@0, @1, @2, @3, @4];
//    
//    [myStringArray reduce:^id(id element, NSUInteger index) {
//        //pass
//    }];
//    
//    [myIntegerArray reduce:^id(id element, NSUInteger index) {
//        NSUInteger x = (NSUInteger)element + (NSUInteger)myIntegerArray[index - 1];
//        return x;
//    }];
//}

- (void)testFilterBlock
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
    
    XCTAssertTrue([filteredIntegerArray isEqual:@[@3]], @"Integer elements are filtered correctly");
    
    NSArray *filteredStringArray = [myStringArray filter:^BOOL(id element, NSUInteger index) {
        if ([element isEqualToString:@"String 1"]) {
            return TRUE;
        }
        return FALSE;
    }];
    
    XCTAssertTrue([filteredStringArray isEqual:@[@"String 1"]], @"String elements are filtered correctly");
    
}


//TODO: Write a better test... not sure if this is testing anything other than iteration
- (void)testForEachBlock
{
    NSArray *myArray = @[@"String 1", @"String 2"];
    [myArray forEach:^BOOL(id element, NSUInteger index) {
        if (index == 0) {
            XCTAssertTrue([element  isEqual: @"String 1"], @"Elements are in expected places");
        } else if (index == 1) {
            XCTAssertTrue([element isEqual: @"String 2"], @"Elements are in expected places");
        }
        XCTAssertTrue(element == myArray[index], @"Element is equal to it's position in array");
        return YES;
    }];
}

@end
