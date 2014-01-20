//
//  GFFavorite.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/12/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFFavorite.h"

#import "NSDate+DateHelper.h"

@implementation GFFavorite

@synthesize startTime = _startTime;
@synthesize endTime = _endTime;

@synthesize cancelledDates = _cancelledDates;


#pragma mark - Getters

- (TimeString*) startTime {
    if (_startTime == nil) {
        NSArray* timeStrings = [[_GFClass objectForKey: @"timeRange"] componentsSeparatedByString: @" - "];
        _startTime = [[TimeString alloc] initWithString: timeStrings[0]];
        _endTime = [[TimeString alloc] initWithString: timeStrings[1]];
    }
    return _startTime;
}

- (TimeString*) endTime {
    if (_endTime == nil) {
        NSArray* timeStrings = [[_GFClass objectForKey: @"timeRange"] componentsSeparatedByString: @" - "];
        _startTime = [[TimeString alloc] initWithString: timeStrings[0]];
        _endTime = [[TimeString alloc] initWithString: timeStrings[1]];
    }
    return _endTime;
}


- (NSArray*) cancelledDates {
    if (_cancelledDates == nil) {
        NSArray* dates = @[];
        for (NSString* dateString in [_GFClass objectForKey: @"cancelledDates"]) {
            dates = [dates arrayByAddingObject: [NSDate dateWithDateString: dateString]];
        }
        _cancelledDates = dates;
    }
    return _cancelledDates;
}
#pragma mark Pseudo Getters

- (NSString*) className {
    return [_GFClass objectForKey: @"className"];
}

- (NSString*) instructor {
    return [_GFClass objectForKey: @"instructor"];
}

- (NSString*) location {
    return [_GFClass objectForKey: @"location"];
}

- (NSDate*) startDate {
    return [NSDate dateWithDateString: [_GFClass objectForKey: @"startDate"]];
    
}

- (NSDate*) endDate {
    return [NSDate dateWithDateString: [_GFClass objectForKey: @"endDate"]];
}

- (BOOL) oneDayClass {
    return [self.startDate compare: self.endDate] == NSOrderedSame;
}

- (NSUInteger) weekDay {
    return [[_GFClass objectForKey: @"dayOfWeek"] intValue];
}


#pragma mark - Initialization

- (id) initWithGFClass: (NSDictionary*) GFClass {
    self = [super init];
    if (self) {
        self.GFClass = GFClass;
    }
    return self;
}

- (BOOL) isEqualToGFClass: (NSDictionary*) GFClass {
    return [[self.GFClass objectForKey: @"_id"] isEqualToString: [GFClass objectForKey: @"_id"]];
}

- (NSComparisonResult) compare: (GFFavorite*) favorite {
    switch ([self.startDate compare: favorite.startDate]) {
        case NSOrderedAscending:
            return NSOrderedAscending;
        case NSOrderedDescending:
            return NSOrderedDescending;
        default: //ns ordered same
            return [self.startTime compareTimeString: favorite.startTime];
    }
}


@end
