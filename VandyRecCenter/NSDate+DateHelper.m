//
//  NSObject+DateHelper.m
//  VandyRecCenter
//
//  Created by Aaron Smith on 10/5/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "NSDate+DateHelper.h"

@implementation NSDate (DateHelper)

NSUInteger _day;
NSUInteger _weekDay;
NSUInteger _month;
NSUInteger _year;

#pragma mark - Getters

// Day methods

- (NSUInteger)day {
    if (!_day) {
        NSString* dateString = [self createDateString];
        _day = [[[dateString componentsSeparatedByString: @"/"] objectAtIndex: 1] intValue];
    }
    return _day;
}

- (NSUInteger) dayForTimeZone:(NSTimeZone *)timeZone {
    NSString* dateString = [self createDateStringFromTimeZone:timeZone];
    return [[[dateString componentsSeparatedByString: @"/"] objectAtIndex: 1] intValue];
}

// Weekday methods

- (NSUInteger)weekDay {
    if (!_weekDay) {
        NSUInteger secondsSince1970 = [self timeIntervalSince1970] - [[NSTimeZone defaultTimeZone] secondsFromGMT];
        NSUInteger daysSince1970 = secondsSince1970/ (60 * 60 * 24);
        NSUInteger dayOfWeek =  (4 + daysSince1970) % 7;
        
        return dayOfWeek;
    }
    return _weekDay;
}

- (NSUInteger) weekDayForTimeZone:(NSTimeZone*)timeZone {
    NSUInteger secondsSince1970 =  [self timeIntervalSince1970] - ([timeZone secondsFromGMT] - [[NSTimeZone defaultTimeZone] secondsFromGMT]);
    
    NSUInteger daysSince1970 = secondsSince1970 / (60 * 60 * 24);
    NSUInteger dayOfWeek =  (4 + daysSince1970) % 7;
    
    return dayOfWeek;
}

// Month methods

- (NSUInteger)month {
    if (!_month) {
        NSString* dateString = [self createDateString];
        return [[[dateString componentsSeparatedByString: @"/"] objectAtIndex: 0] intValue] - 1;
    }
    return _month;
}

- (NSUInteger) monthForTimeZone:(NSTimeZone *)timeZone {
    NSString* dateString = [self createDateStringFromTimeZone:timeZone];
    return [[[dateString componentsSeparatedByString: @"/"] objectAtIndex: 0] intValue] - 1;
}

// Year methods

- (NSUInteger)year {
    if (!_year) {
        NSString* dateString = [self createDateString];
        _year = [[[dateString componentsSeparatedByString: @"/"] objectAtIndex: 2] intValue];
        
        if (_year < 70) {
            _year += 2000;
        } else {
            _year += 1900;
        }
    }
    
    return _year;
}

- (NSUInteger) yearForTimeZone:(NSTimeZone *)timeZone {
    NSString* dateString = [self createDateStringFromTimeZone: timeZone];
    NSUInteger year = [[[dateString componentsSeparatedByString: @"/"] objectAtIndex: 2] intValue];
    
    if (year < 70) {
        year += 2000;
    } else {
        year += 1900;
    }
    
    return year;
}

#pragma mark - Helper Methods

- (NSString *) createDateString {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT: 0];
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateStyle = NSDateFormatterShortStyle;
    
    return [formatter stringFromDate: self];
}

- (NSString *) createDateStringFromTimeZone:(NSTimeZone*) timeZone {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = timeZone;
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateStyle = NSDateFormatterShortStyle;
    
    return [formatter stringFromDate: self];
}

#pragma mark - Time Manipulation Methods

//returns an NSDate object with the same day as the current instance but
//set to a different time
- (NSDate*) dateBySettingTimeToTime:(NSString *)time {
    
    //get seconds
    NSUInteger currentTime = (int) [self timeIntervalSince1970];
    
    //remove any seconds that are carried over by the day
    NSUInteger newInterval = currentTime - (currentTime% (60*60*24));
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSince1970: newInterval];
    
    //midnight does not add any time to the current date
    newDate = [newDate dateByAddingTimeInterval: [NSDate timeInMinutes: time ] * 60];
    return newDate;
}

- (NSDate*) dateByIncrementingDay {
    return [self dateByAddingTimeInterval: 24*60*60];
}

- (NSDate*) dateByDecrementingDay {
    return [self dateByAddingTimeInterval: -24*60*60];
}

+ (id) dateByAddingTimeCurrentTime:(NSTimeInterval)addedTime {
    NSDate* currentDate = [[NSDate alloc] init];
    return [currentDate dateByAddingTimeInterval: addedTime];
}

+ (BOOL) isLeapYear: (NSUInteger) year {
    if (year % 4 == 0) {
        if (year % 100 != 0 || year % 400 == 0) {
            return YES; // leap year
        }
    }
    return NO; // NOT a leap year
}

+ (id) dateWithYear:(NSUInteger)year month:(NSUInteger)month andDay:(NSUInteger)day {
    assert(year >= 1970);
    NSUInteger leapYearCount = 0;
    for (NSUInteger start = 1972; start < year; start++) {
        BOOL isLeapYear = [NSDate isLeapYear: start];
        if (isLeapYear == TRUE) {
            leapYearCount++;
        }
    }
    
    NSTimeInterval secondsSince1970 = 0;
    //seconds from year
    secondsSince1970 += (year - 1970) * 365 * 24 * 60 * 60;
    
    //add missing days from leap years
    secondsSince1970 += (leapYearCount * 24 * 60 * 60);
    
    //seconds from month
    for (NSInteger index = 1; index < (NSInteger) month; index++) { //Only counts to the last month, not to current month
        NSUInteger daysInMonth = 0;
        
        if (index == 4 || index == 6 || index == 9 || index == 11) {
            daysInMonth = 30;
            break;
        } else if (index == 2) {
            BOOL isLeapYear = [self isLeapYear: year];
            if (isLeapYear == FALSE) {
                daysInMonth = 28;
            } else {
                daysInMonth = 29;
            }
            break;
        } else {
            daysInMonth = 31;
            break;
        }
        
        secondsSince1970 += (daysInMonth * 24 * 60 * 60);
    }
    
    //seconds from days
    secondsSince1970 += ((day-1) * 24 * 60 * 60);
    
    return [[NSDate alloc] initWithTimeIntervalSince1970: secondsSince1970];
}

+ (id) dateWithDateString:(NSString *)dateString {
    //this regular expression only makes sure that the date string is in the correct format
    //with some error checking of the actual digits, but does not check if the number
    //of days are valid for a specific month
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern: @"^((0?\\d)|(1[012]))/[0123]?\\d/((19\\d\\d)|(20\\d\\d))$" options: NSRegularExpressionAnchorsMatchLines error:nil];
    if ([regex numberOfMatchesInString: dateString options: NSMatchingAnchored range: NSMakeRange(0, [dateString length])] == 1) {
        
        NSArray* dateArray = [dateString componentsSeparatedByString: @"/"];
        NSUInteger year = [[dateArray objectAtIndex: 2] intValue];
        NSUInteger month = [[dateArray objectAtIndex: 0] intValue];
        NSUInteger day = [[dateArray objectAtIndex: 1] intValue];
        return [NSDate dateWithYear:year month:month andDay:day];
        
    } else {
        return nil;
    }
}

#pragma mark - Private Methods

//private methods here
//if earlyMidnight is true, midnight is represented as 0 hours
//if early midnight is false, midnight is represent as 24 hours
//regardless of how midnight is represented a minute after midnight will return 1 minute
+ (NSUInteger) timeInMinutes: (NSString*) time { //time must be in format 12:00am
    
    NSUInteger timeInHours;
    NSUInteger timeInMinutes;
    BOOL isPM = NO;
    if ([[[time substringFromIndex: ([time length] - 2) ] lowercaseString] isEqualToString: @"pm"]) {
        isPM = YES;
    }
    for (size_t i = 0; i < [time length]; ++i) {
        if ([time characterAtIndex: i] == ':') {
            timeInHours = (NSUInteger) [[time substringWithRange: NSMakeRange(0, i)] intValue];
            timeInMinutes = (NSUInteger)[ [time substringWithRange:NSMakeRange(i+1, 2)] intValue];
        }
    }
    
    //if it is midnight, just return 0 minutes
    if (timeInHours == 12 && timeInMinutes == 0 && !isPM) {
        return 0;
    }
    
    NSUInteger totalMinutes = (!isPM && timeInHours == 12) ? timeInMinutes : 60 * timeInHours + timeInMinutes;
    totalMinutes += (isPM && timeInHours != 12) ? (12*60) : 0;
    return totalMinutes;
}

@end
