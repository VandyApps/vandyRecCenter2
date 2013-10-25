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
    NSMutableArray* filteredArray = [[NSMutableArray alloc] init];
    
    for (id element in self) { // Is self the array?
        NSUInteger elementIndex = [self indexOfObject:element];
        if (block(element, elementIndex)) [filteredArray addObject:element];
    }
    
    return filteredArray;
};

- (id) reduce: (id (^)(id element, NSUInteger index)) block {
    id element;
    
    if (!element || ![element count]) { // check that there are methods in array?
        [NSException raise:@"Invalid Array" format:@"Array is empty or null"];
    }
    
    id reducedValue;
    
    for (element in self) {
        NSUInteger elementIndex = [self indexOfObject:element];
        reducedValue = block(element, elementIndex);
    }
    
    return reducedValue;
    
};

- (void) forEach: (BOOL (^)(id element, NSUInteger index)) block {
    for (id element in self) {
        NSUInteger elementIndex = [self indexOfObject:element];
        block(element, elementIndex);
    }
};

@end
