//
//  GFSpecialDates.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 6/2/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFSpecialDates.h"

@interface GFSpecialDates()

@property (nonatomic, strong) RecClient* webClient;

@end

@implementation GFSpecialDates

#pragma mark - Getter

- (RecClient*) webClient {
    if (_webClient == nil) {
        _webClient = [[RecClient alloc] init];
    }
    return _webClient;
}


#pragma mark - Public

- (void) loadData:(void (^)(NSError *, GFSpecialDates *))block {
    
    
    if (self.specialDates == nil) {
       
        //month and year do not matter for special dates type
        [self.webClient fetchGroupFitnessSpecialDates:^(NSError *error, NSArray *specialDates) {
            
            if (specialDates != nil) {
                self.specialDates = specialDates;
            }
            block(error, self);
            
        }];

    } else {
        block(nil, self);
    }
}

- (BOOL) isSpecialDateForDate:(NSDate *)date {
    if ([self specialDateForDate: date] == nil) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL) isSpecialDateForYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    return [self isSpecialDateForDate: [NSDate dateWithYear: year month: month andDay: day]];
}

- (NSDictionary*) specialDateForDate:(NSDate *)date {
    
    for (NSDictionary* specialDate in self.specialDates) {
        NSDate* startDate = [NSDate dateWithDateString: [specialDate objectForKey: @"startDate"]];
        NSDate* endDate = [NSDate dateWithDateString: [specialDate objectForKey: @"endDate"]];
        if (([date compare: startDate] == NSOrderedDescending || [date compare: startDate] == NSOrderedSame) && ([date compare: endDate] == NSOrderedAscending || [date compare: endDate] == NSOrderedSame)) {
            return specialDate;
        }
    }
    return nil;
}

- (NSDictionary*) specialDateForYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    return [self specialDateForYear: year month: month day: day];
}


@end
