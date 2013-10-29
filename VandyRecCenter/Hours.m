//
//  Hours.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "Hours.h"
#import "TimeString.h"
#import "RecClient.h"
#import "NSArray+MyArrayClass.h"
#import "NSDate+DateHelper.h"

@implementation Hours

@synthesize hours = _hours;

- (NSArray*) hours {
    if (!_hours) {
        // What do I do here? call loadData?
    }
    return _hours;
}

- (void) loadData:(void (^)(NSError* error, Hours* hoursModel))block {
    RecClient* webClient = [RecClient sharedClient];
    
    [webClient fetchHours:^(NSError *error, NSArray *hours) {
        if (!error) {
            _hours = hours;
        }
        block(error, self);
    }];
}

// Grabs first occurrence where name in dict matches parameter name
- (NSDictionary*) hoursWithTitle:(NSString *)hoursTitle {
    __block NSDictionary* hours;
    [_hours forEach:^BOOL(id element, NSUInteger index) {
        if ([[element objectForKey:@"name"] isEqualToString:hoursTitle]) {
            hours = element;
            return YES; // isDone = YES
        }
        return NO; // isDone = NO
    }];
    
    return hours;
}

- (NSArray*) defaultHours {
    return [_hours filter:^BOOL(id element, NSUInteger index) {
        NSNumber *priority = [element objectForKey:@"priorityNumber"];
        NSLog(@"priority: %@", priority);
        if ([priority isEqualToNumber:@0]) {
            return TRUE;
        }
        return FALSE;
    }];
}


@end
