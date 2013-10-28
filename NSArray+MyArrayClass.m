//
//  NSArray+MyArrayClass.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "NSArray+MyArrayClass.h"

@implementation NSArray(MyArrayClass)

// Pass each element of the array into a callback function.
// If the callback function returns true, place the element in
// the resulting array.
- (NSArray*) filter: (BOOL (^)(id element, NSUInteger index)) block {
    NSArray* filteredArray = [[NSArray alloc] init];
    
    for (id item in self) { // Is self the array?
        NSUInteger elementIndex = [self indexOfObject:item];
        if (block(item, elementIndex)) filteredArray = [filteredArray arrayByAddingObjectsFromArray: item];
    }
    
    return filteredArray;
};

// I think this needs lastItem/nextItem parameters like in javascript
- (NSInteger) reduce: (NSInteger (^)(NSInteger memo, id element, NSUInteger index)) block {
    return 0;
};


// What do I need to test to return a bool?
- (void) forEach: (BOOL (^)(id element, NSUInteger index)) block {
    BOOL isDone = NO;
    for (NSUInteger i = 0; i < self.count && !isDone; ++i) {
        isDone = isDone || block(self[i], i);
    }
};

@end
