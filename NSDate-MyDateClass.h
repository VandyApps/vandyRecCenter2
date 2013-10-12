//contains general extension to the NSDate class

#import <Foundation/Foundation.h>

@interface NSDate(MyDateClass)

//make this negative to subtract time
+ (NSDate*) dateByAddingTimeCurrentTime: (NSTimeInterval) addedTime;

+ (NSDate*) dateWithYear: (NSUInteger) year month: (NSUInteger) month andDay: (NSUInteger) day;
//dateString is an NSString in the form MM/DD/YYYY where
//MM is the month as a 1-based index, so 01 is January and 12 is December,
//day is also 1-based.  Returns nil if an invalid dateString is sent
+ (NSDate*) dateWithDateString: (NSString*) dateString;

//accepts string in format: 12:00am or 12:00 AM
- (NSDate*) dateBySettingTimeToTime: (NSString*) time; 
- (NSDate*) dateByIncrementingDay;
- (NSDate*) dateByDecrementingDay;

//getters for the day, month, and year
- (NSUInteger) day;
//this is 0-based, so January is 0, December is 11
- (NSUInteger) month;
- (NSUInteger) year;
- (NSUInteger) weekDay;

- (NSUInteger) dayForTimeZone: (NSTimeZone*) timeZone;
- (NSUInteger) monthForTimeZone: (NSTimeZone*) timeZone;
- (NSUInteger) yearForTimeZone: (NSTimeZone*) timeZone;
- (NSUInteger) weekDayForTimeZone: (NSTimeZone*) timeZone;

+ (NSUInteger) day;
+ (NSUInteger) month;
+ (NSUInteger) year;
+ (NSUInteger) weekDay;

+ (NSUInteger) dayForTimeZone: (NSTimeZone*) timeZone;
+ (NSUInteger) monthForTimeZone: (NSTimeZone*) timeZone;
+ (NSUInteger) yearForTimeZone: (NSTimeZone*) timeZone;
+ (NSUInteger) weekDayForTimeZone: (NSTimeZone*) timeZone;


@end
