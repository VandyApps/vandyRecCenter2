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
    for (NSUInteger i = 0; i < self.count; i++) {
        if (block(self[i], i)) filteredArray = [filteredArray arrayByAddingObject: self[i]];
    }
    
    return filteredArray;
};

// I think this needs lastItem/nextItem parameters like in javascript
- (NSInteger) reduce: (NSInteger (^)(NSInteger memo, id element, NSUInteger index)) block {
    NSInteger lastValue = 0;
    for (NSUInteger i = 0; i < self.count; i++) {
        lastValue = block(lastValue, self[i], i);
    }
    return lastValue;
};


- (void) forEach: (BOOL (^)(id element, NSUInteger index)) block {
    BOOL isDone = NO;
    for (NSUInteger i = 0; i < self.count && !isDone; i++) {
        isDone = isDone || block(self[i], i);
    }
};

@end
