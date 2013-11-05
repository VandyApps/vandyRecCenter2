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

# pragma mark - Sort by title

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

# pragma mark - Hours types
// Filters hours and returns array of all hours where priorityNumber == 0
- (NSArray*) defaultHours {
    return [_hours filter:^BOOL(id element, NSUInteger index) {
        NSNumber *priority = [element objectForKey:@"priorityNumber"];
        if ([priority isEqualToNumber:@0]) {
            return YES;
        }
        return NO;
    }];
}

// Filters hours and returns array of all hours where facilityHours == true
- (NSArray*) facilityHours {
    return [_hours filter:^BOOL(id element, NSUInteger index) {
        NSNumber *isFacilityHours = [element objectForKey:@"facilityHours"];
        if ([isFacilityHours isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            return YES;
        }
        return NO;
    }];
}

// Filters hours and returns array of all hours where closedHours == true
- (NSArray*) closedHours {
    return [_hours filter:^BOOL(id element, NSUInteger index) {
        NSNumber *isClosedHours = [element objectForKey:@"closedHours"];
        if ([isClosedHours isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            return YES;
        }
        return NO;
    }];
}

// Filters hours, returns array of all hours where priorityNumber != 0,
// facilityHours == false, and closedHours == false
- (NSArray*) otherHours {
    return [_hours filter:^BOOL(id element, NSUInteger index) {
        BOOL isClosedHours = [[element objectForKey:@"closedHours"] boolValue];
        BOOL isFacilityHours = [[element objectForKey:@"facilityHours"] boolValue];
        NSNumber *priority = [element objectForKey:@"priorityNumber"];
        
        if (!isClosedHours && !isFacilityHours && [priority intValue] != 0) {
            return YES;
        }
        return NO;
    }];
}

# pragma mark - Current hours methods

/* TODO PROBLEMS: 1. What if dict for today is empty? How to fall back?
             2. What if the priority number and dates are the same?
*/

// Uses starting/ending dates, priority number, and times (with timeString)
// to determine the current hours

// TODO make it use timezone
- (NSDictionary*) currentHours {
    NSDate *today = [[NSDate alloc] init]; // get today's date object
    
    // get array of hours dicts where closed == false and facilityHours == true
    NSArray *facilityAndNotClosedHours = [_hours filter:^BOOL(id element, NSUInteger index) {
        BOOL isClosedHours = [[element objectForKey:@"closedHours"] boolValue];
        BOOL isFacilityHours = [[element objectForKey:@"facilityHours"] boolValue];
        
        if (!isClosedHours && isFacilityHours) {
            return YES;
        }
        return NO;
    }];
    
    // compare today's date to start/end dates to find matching dicts
    NSArray *withinDateRange = [facilityAndNotClosedHours filter:^BOOL(id element, NSUInteger index) {
        NSString *startDateString = [element objectForKey:@"startDate"];
        NSString *endDateString = [element objectForKey:@"endDate"];
        NSDate *startDate = [NSDate dateWithDateString:startDateString];
        NSDate *endDate = [NSDate dateWithDateString:endDateString];
        BOOL isAfterStart = [self myDate:today isAfterDate:startDate];
        BOOL isBeforeEnd = [self myDate:today isBeforeDate:endDate];
        
        if (isAfterStart && isBeforeEnd) {
            return YES;
        }
        
        return NO;
    }];
    
    // filter by priority where highest priority is kept and last is discarded
    __block NSDictionary *hours;
    NSNumber *priority = @-1;
    [withinDateRange forEach:^BOOL(id element, NSUInteger index) {
        // check that priority is less than the element's priority number
        if ([[element objectForKey:@"priorityNumber"] compare:priority] == NSOrderedDescending) {
            hours = element;
            return YES;
        }
        return NO;
    }];
        
    // select dict matching today's weekday
    NSArray *times = [hours objectForKey:@"times"];
    // TODO check time zone and stuff for weekday
    NSDictionary *currentHours = times[today.weekDay - 1]; // subtract one because Sunday should be 0
    
    // return dict of today's hours with highest priority
    return currentHours;
}


# pragma mark - Hours Comparison Helpers
// Helpers for currentHours method
- (BOOL) myDate:(NSDate*)date isBeforeDate:(NSDate*)anotherDate {
    if ([date compare:anotherDate] == NSOrderedAscending) {
        return YES; // before date
    } else {
        return FALSE; // after or equal to date
    }
}

- (BOOL) myDate:(NSDate*)date isAfterDate:(NSDate*)anotherDate {
    return ![self myDate:date isBeforeDate:anotherDate];
}

# pragma mark - Open/Closed Methods

- (TimeString*) openingTime {
    NSString* openingHoursString = [[self currentHours] objectForKey:@"startTime"];
    return [[TimeString alloc] initWithString:openingHoursString];
}

- (TimeString*) closedTime {
    NSString* closingHoursString = [[self currentHours] objectForKey:@"endTime"];
    return [[TimeString alloc] initWithString:closingHoursString];
}

# pragma mark - Boolean methods

- (BOOL) isOpen {
    TimeString* currentTime = [[TimeString alloc] initWithTimeZone:[NSTimeZone localTimeZone]];
    NSComparisonResult openTimeComparison = [currentTime compareTimeString:[self openingTime]];
    NSComparisonResult closedTimeComparison = [currentTime compareTimeString:[self closedTime]];
    
    if ((openTimeComparison == NSOrderedDescending && closedTimeComparison == NSOrderedAscending)
        || openTimeComparison == NSOrderedSame) {
        // current time is the same as the opening time up to (and not including) the closing time
        return TRUE;
    }
    
    return FALSE;
}

# pragma mark - 'Time until' methods


@end
