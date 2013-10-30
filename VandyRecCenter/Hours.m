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

// Filters hours and returns array of all hours where priorityNumber == 0
- (NSArray*) defaultHours {
    return [_hours filter:^BOOL(id element, NSUInteger index) {
        NSNumber *priority = [element objectForKey:@"priorityNumber"];
        if ([priority isEqualToNumber:@0]) {
            return TRUE;
        }
        return FALSE;
    }];
}

// Filters hours and returns array of all hours where facilityHours == true
- (NSArray*) facilityHours {
    return [_hours filter:^BOOL(id element, NSUInteger index) {
        NSNumber *isFacilityHours = [element objectForKey:@"facilityHours"];
        if ([isFacilityHours isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            return TRUE;
        }
        return FALSE;
    }];
}

// Filters hours and returns array of all hours where closedHours == true
- (NSArray*) closedHours {
    return [_hours filter:^BOOL(id element, NSUInteger index) {
        NSNumber *isClosedHours = [element objectForKey:@"closedHours"];
        if ([isClosedHours isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            return TRUE;
        }
        return FALSE;
    }];
}

// Filters hours, returns array of all hours where priorityNumber != 0,
// facilityHours == false, and closedHours == false
- (NSArray*) otherHours {
    return [_hours filter:^BOOL(id element, NSUInteger index) {
        NSNumber *isClosedHours = [element objectForKey:@"closedHours"];
        NSNumber *isFacilityHours = [element objectForKey:@"facilityHours"];
        NSNumber *priority = [element objectForKey:@"priorityNumber"];
        NSLog(@"isClosedHours: %@", isClosedHours);
        
        if (!isClosedHours
            && ![isFacilityHours isEqualToNumber:[NSNumber numberWithBool:YES]]
            && ![priority isEqualToNumber:@0]) {
            return TRUE;
        }
        return FALSE;
    }];
}

// Uses starting/ending dates, priority number, and times (with timeString)
// to determine the current hours
- (NSDictionary*) currentHours {
    __block NSDictionary* hours = [[NSDictionary alloc] init];
    [_hours forEach:^BOOL(id element, NSUInteger index) {
        // get today's date
        
        // get array of hours dicts where closed != true and facilityHours == true
        
        // get today's day of week
        
        // get the hours of the corresponding day of week in the dict
        
        // compare today's date to start/end dates on the right day to find matching dicts
        
        // return dict of today's hours with highest priority
        return 0;
    }];
    return 0;
}


@end
