//
//  NSArray+MyArrayClass.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(MyArrayClass)

- (NSArray*) filter: (BOOL (^)(id element, NSUInteger index)) block;
- (id) reduce: (id (^)(id element, NSUInteger index)) block;

//block returns true to continue, false to exit
- (void) forEach: (BOOL (^)(id element, NSUInteger index)) block;

@end
