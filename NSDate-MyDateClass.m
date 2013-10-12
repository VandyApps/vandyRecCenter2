


#import "NSDate-MyDateClass.h"

@implementation NSDate(MyDateClass)

+ (NSDate*) dateByAddingTimeCurrentTime:(NSTimeInterval)addedTime {
    NSDate* currentDate = [[NSDate alloc] init];
    return [currentDate dateByAddingTimeInterval: addedTime];
}


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

+ (NSDate*) dateWithDateString:(NSString *)dateString {
    //this regular expression only makes sure that the date string is in the correct format
    //with some error checking of the actual digits, but does not check if the number
    //of days are valid for a specific month
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern: @"^((0?\\d)|(1[012]))/[0123]?\\d/((19\\d\\d)|(20\\d\\d))$" options: NSRegularExpressionAnchorsMatchLines error:nil];
    if ([regex numberOfMatchesInString: dateString options: NSMatchingAnchored range: NSMakeRange(0, [dateString length])] == 1) {
        
        NSArray* dateArray = [dateString componentsSeparatedByString: @"/"];
        NSUInteger year = [[dateArray objectAtIndex: 2] intValue];
        NSUInteger month = [[dateArray objectAtIndex: 0] intValue] - 1;
        NSUInteger day = [[dateArray objectAtIndex: 1] intValue];
        return [NSDate dateWithYear:year month:month andDay:day];
        
    } else {
        return nil;
    }
}

- (NSDate*) dateByIncrementingDay {
    return [self dateByAddingTimeInterval: 24*60*60];
}

- (NSDate*) dateByDecrementingDay {
    return [self dateByAddingTimeInterval: -24*60*60];
}


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

+ (NSDate*) dateWithYear:(NSUInteger)year month:(NSUInteger)month andDay:(NSUInteger)day {
    
    assert(year >= 1970);
    NSUInteger leapYearCount = 0;
    for (NSUInteger start = 1972; start < year; start++) {
        if (start % 4 == 0) {
            leapYearCount++;
        }
    }
    
    NSTimeInterval secondsSince1970 = 0;
    //seconds from year
    secondsSince1970 += (year - 1970) * 365 * 24 * 60 * 60;
    
    //add missing days from leap years
    secondsSince1970 += (leapYearCount * 24 * 60 * 60);
    
    //seconds from month
    for (NSInteger index = (NSInteger) month - 1; index >= 0; index--) {
        NSUInteger daysInMonth = 0;
        
        switch (index) {
            case 0:
            case 2:
            case 4:
            case 6:
            case 7:
            case 9:
            case 11:
                daysInMonth = 31;
                break;
            case 3:
            case 5:
            case 8:
            case 10:
                daysInMonth = 30;
                break;
            default:
                if (year % 4 == 0) {
                    daysInMonth = 29;
                } else {
                    daysInMonth = 28;
                }
                break;
        }
        secondsSince1970 += (daysInMonth * 24 * 60 * 60);
        
    }
    
    //seconds from days
    secondsSince1970 += ((day-1) * 24 * 60 * 60);
     
    return [[NSDate alloc] initWithTimeIntervalSince1970: secondsSince1970];
}


#pragma mark - Getters
- (NSUInteger) day {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT: 0];
    NSString* dateString = [formatter stringFromDate: self];
    
    return [[[dateString componentsSeparatedByString: @"/"] objectAtIndex: 1] intValue];
}

- (NSUInteger) dayForTimeZone:(NSTimeZone*) timeZone {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = timeZone;
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateStyle = NSDateFormatterShortStyle;
    NSString* dateString = [formatter stringFromDate: self];
    return [[[dateString componentsSeparatedByString: @"/"] objectAtIndex: 1] intValue];
    
}

- (NSUInteger) month {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT: 0];
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateStyle = NSDateFormatterShortStyle;
    NSString* dateString = [formatter stringFromDate: self];
    
    return [[[dateString componentsSeparatedByString: @"/"] objectAtIndex: 0] intValue] -1;
}

- (NSUInteger) monthForTimeZone:(NSTimeZone *)timeZone {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = timeZone;
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateStyle = NSDateFormatterShortStyle;
    NSString* dateString = [formatter stringFromDate: self];
    
    return [[[dateString componentsSeparatedByString: @"/"] objectAtIndex: 0] intValue] -1;

}

- (NSUInteger) year {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT: 0];
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateStyle = NSDateFormatterShortStyle;
    NSString* dateString = [formatter stringFromDate: self];
   
    
    NSUInteger year = [[[dateString componentsSeparatedByString: @"/"] objectAtIndex:2] intValue];
    if (year < 70) {
        year += 2000;
    } else {
        year += 1900;
    }
    return year;
}

- (NSUInteger) yearForTimeZone:(NSTimeZone *)timeZone {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = timeZone;
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateStyle = NSDateFormatterShortStyle;
    NSString* dateString = [formatter stringFromDate: self];
    
    
    NSUInteger year = [[[dateString componentsSeparatedByString: @"/"] objectAtIndex:2] intValue];
    if (year < 70) {
        year += 2000;
    } else {
        year += 1900;
    }
    return year;
}

- (NSUInteger) weekDay {
    NSUInteger secondsSince1970 = [self timeIntervalSince1970] - [[NSTimeZone defaultTimeZone] secondsFromGMT];
    NSUInteger daysSince1970 = secondsSince1970/ (60 * 60 * 24);
    NSUInteger dayOfWeek =  (4 + daysSince1970) % 7;
    
    return dayOfWeek;
}

- (NSUInteger) weekDayForTimeZone: (NSTimeZone*) timeZone {
    
    NSUInteger secondsSince1970 =  [self timeIntervalSince1970] - ([timeZone secondsFromGMT] - [[NSTimeZone defaultTimeZone] secondsFromGMT]);
    
    NSUInteger daysSince1970 = secondsSince1970/ (60 * 60 * 24);
    NSUInteger dayOfWeek =  (4 + daysSince1970) % 7;
    
    return dayOfWeek;
}

#pragma mark - week day methods

+ (NSUInteger) day {
    return [[[NSDate alloc] init] day];
}

+ (NSUInteger) month {
    return  [[[NSDate alloc] init] month];
}

+ (NSUInteger) year {
    return [[[NSDate alloc] init] year];
}

+ (NSUInteger) weekDay {
    return [[[NSDate alloc] init] weekDay];
}

+ (NSUInteger) dayForTimeZone:(NSTimeZone *)timeZone {
    return [[[NSDate alloc] init] dayForTimeZone: timeZone];
}

+ (NSUInteger) monthForTimeZone:(NSTimeZone *)timeZone {
    return [[[NSDate alloc] init] monthForTimeZone: timeZone];
}

+ (NSUInteger) yearForTimeZone:(NSTimeZone *)timeZone {
    return [[[NSDate alloc] init] yearForTimeZone: timeZone];
}

+ (NSUInteger) weekDayForTimeZone:(NSTimeZone *)timeZone {
    return [[[NSDate alloc] init] weekDayForTimeZone: timeZone];
}



@end
