//
//  TimeString.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

//represents the style that the time string is
//represented as
typedef enum {
    TimeStringStyleMilitary = 0,
    TimeStringStyleAMPM,
    TimeStringStyleAMPMSpaced
} TimeStringStyle;


#import <Foundation/Foundation.h>
//this class is for parsing and validating time strings
//of the following formats:
// 12:00 am
// 6:30am
// 14:37
//if am or pm is not specified, then the time string
//is assumed to be in military time
//there could or could not be a space in between the
//time and the am/pm indication
//am and pm are case insensitive

@interface TimeString : NSObject

@property (nonatomic) BOOL isAM;
@property (nonatomic) NSUInteger hours;
@property (nonatomic) NSUInteger minutes;
@property (nonatomic) TimeStringStyle style;

//default initializer
- (id) initWithString: (NSString*) timeString;

//initializes with the current time
- (id) init;
//intializes with the current time in the passed in time zone
- (id) initWithTimeZone: (NSTimeZone*) timeZone;
//prints out the string according to the time string style
- (NSString*) stringValue;

- (NSUInteger) timeInMinutes;
- (NSUInteger) timeInSeconds;

+ (NSComparisonResult) compareTimeString1: (TimeString*) timeString1 timeString2: (TimeString*) timeString2;
- (NSComparisonResult) compareTimeString: (TimeString*) timeString;

+ (BOOL) validTimeString: (NSString*) timeString;
@end
