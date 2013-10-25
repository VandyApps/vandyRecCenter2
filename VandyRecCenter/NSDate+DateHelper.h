//
//  NSObject+DateHelper.h
//  VandyRecCenter
//
//  Created by Aaron Smith on 10/5/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

// Stuff having to do with timezones should be in methods
// date, month, year etc in properties

#import <Foundation/Foundation.h>

@interface NSDate (DateHelper)

@property (nonatomic, readonly) NSUInteger day;
@property (nonatomic, readonly) NSUInteger weekDay;
@property (nonatomic, readonly) NSUInteger month;
@property (nonatomic, readonly) NSUInteger year;

- (NSUInteger) dayForTimeZone: (NSTimeZone*) timeZone;
- (NSUInteger) monthForTimeZone: (NSTimeZone*) timeZone;
- (NSUInteger) yearForTimeZone: (NSTimeZone*) timeZone;
- (NSUInteger) weekDayForTimeZone: (NSTimeZone*) timeZone;

// Helper Methods
- (NSString*) createDateString;
- (NSString*) createDateStringFromTimeZone: (NSTimeZone*) timeZone;


// Time Manipulation methods
- (NSDate*) dateBySettingTimeToTime: (NSString *) time;
- (NSDate*) dateByIncrementingDay;
- (NSDate*) dateByDecrementingDay;

// Make negative to subtract time
+ (id) dateByAddingTimeCurrentTime: (NSTimeInterval) addedTime;
+ (id) dateWithYear: (NSUInteger) year month: (NSUInteger) month andDay: (NSUInteger) day;

/* dateString is an NSString in the form MM/DD/YYYY where MM is the month as a 1-based index, so 01 is January and 12 is December, day is also 1-based.  Returns nil if an invalid dateString is sent
 */
+ (id) dateWithDateString: (NSString*) dateString;

@end

