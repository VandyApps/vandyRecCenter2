//
//  TimeString.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "TimeString.h"

@implementation TimeString

@synthesize isAM = _isAM;
@synthesize hours = _hours;
@synthesize minutes = _minutes;
@synthesize style = _style;

#pragma mark - Initializer
- (id) initWithString:(NSString *)timeString {
    self = [super init];
    if (self) {
        if ([TimeString validTimeString:timeString]) {
            //the object at the first index has the hours
            //the second index still needs to be parsed 
            NSArray *firstBreak = [timeString componentsSeparatedByString: @":"];
            
            //hours
            NSUInteger hours = [[firstBreak objectAtIndex: 0] intValue];
            //get the minutes
            self.minutes = [[[firstBreak objectAtIndex: 1] substringToIndex: 2] intValue];
            if ([[firstBreak objectAtIndex: 1] length] == 2) {
                
                //no ampm indications so the time is in military
                if (hours > 12) {
                    self.isAM = NO;
                    self.hours = hours - 12;
                } else if (hours == 0) {
                    self.isAM = YES;
                    self.hours = 12;
                } else {
                    self.isAM = YES;
                    self.hours = hours;
                }
                
            } else {
                //not in military time with ampm indicator
                self.hours = hours;
                NSString* indicator = [[firstBreak objectAtIndex: 1] substringFromIndex: 2];
                if ([indicator characterAtIndex: 0] == ' ') {
                    indicator = [indicator substringFromIndex: 1];
                }
                if ([[indicator uppercaseString] isEqualToString: @"AM"]) {
                    self.isAM = YES;
                } else {
                    self.isAM = NO;
                }
            }
        }
        self.style = TimeStringStyleAMPM;
    }
    return self;
}

- (id) init {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterNoStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    self = [self initWithString: [formatter stringFromDate: [[NSDate alloc] init]]];
    return self;
}

- (id) initWithTimeZone:(NSTimeZone *)timeZone {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = timeZone;
    formatter.dateStyle = NSDateFormatterNoStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    self = [self initWithString: [formatter stringFromDate: [[NSDate alloc] init]]];
    return self;
}

#pragma mark - Public
- (NSString*) stringValue {
    NSString* returnString = [[NSString alloc] init];
    
    if (self.style == TimeStringStyleMilitary && !self.isAM) {
        returnString = [returnString stringByAppendingFormat: @"%i:", (self.hours + 12) % 24];
    } else {
        returnString = [returnString stringByAppendingFormat: @"%i:", self.hours];
    }
    if (self.minutes < 10) {
        returnString = [returnString stringByAppendingString: @"0"];
    }
    returnString = [returnString stringByAppendingFormat: @"%i", self.minutes];
    
    NSString* indicator;
    if (self.style == TimeStringStyleAMPM) {
        if (self.isAM) {
            indicator = @"am";
        } else {
            indicator = @"pm";
        }
        returnString = [returnString stringByAppendingString: indicator];
        
    } else if (self.style == TimeStringStyleAMPMSpaced) {
        if (self.isAM) {
            indicator = @" am";
            
        } else {
            indicator = @" pm";
        }
        returnString = [returnString stringByAppendingString: indicator];
    }
    
    return returnString;
}

- (NSString*) description {
    return [self stringValue];
}

- (NSUInteger) timeInMinutes {
   
    NSUInteger minutes = 0;
    if (!self.isAM || self.hours != 12) {
        minutes += (self.hours * 60);
    }
    
    if (!self.isAM && self.hours != 12) {
        minutes += (12 * 60);
    }
    minutes += self.minutes;
    return minutes;
}

- (NSUInteger) timeInSeconds {
    return [self timeInMinutes] * 60;
}

#pragma mark Comparison
+ (NSComparisonResult) compareTimeString1:(TimeString *)timeString1 timeString2:(TimeString *)timeString2 {
    if ([timeString1 timeInMinutes] < [timeString2 timeInMinutes]) {
        return NSOrderedAscending; // timeString1 is prior to timeString2
    } else if ([timeString1 timeInMinutes] > [timeString2 timeInMinutes]) {
        return NSOrderedDescending; // timeString1 is after timeString2
    } else {
        return NSOrderedSame;
    }
}

- (NSComparisonResult) compareTimeString:(TimeString *)timeString {
    return [TimeString compareTimeString1: self timeString2: timeString];
}

#pragma mark  Validation
+ (BOOL) validTimeString:(NSString *)timeString {
    NSRegularExpression* timeRegex = [[NSRegularExpression alloc] initWithPattern: @"(^([0-1]?\\d|2[0-3]):[0-5]\\d$)|(^0?[1-9]:[0-5]\\d\\x20?[a,A,p,P][m,M]$)|(^1[0-2]:[0-5]\\d\\x20?[A,a,p,P][m,M]$)" options:NSRegularExpressionUseUnixLineSeparators error: nil];
    NSUInteger count = [timeRegex numberOfMatchesInString: timeString options: NSMatchingAnchored range: NSMakeRange(0, timeString.length)];
    
    if (count == 1) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Range

// range > 0 if time2 is later than time1; range < 0 if time2 is earlier than time1
+ (NSTimeInterval) timeRangeBetweenTime:(TimeString *)time1 andTime:(TimeString *)time2 {
    NSComparisonResult timeComparison = [time1 compareTimeString:time2];
    if (timeComparison == NSOrderedAscending) {
        return (NSTimeInterval)([time2 timeInSeconds] - [time1 timeInSeconds]);
    } else if (timeComparison == NSOrderedDescending) {
        return -(NSTimeInterval)([time1 timeInSeconds] - [time2 timeInSeconds]);
    }
    
    return 0; // The times are exactly the same
}

@end
