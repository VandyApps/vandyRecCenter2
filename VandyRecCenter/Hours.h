//
//  Hours.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DateHelper.h"

@class TimeString;

@interface Hours : NSObject

@property (nonatomic, strong, readonly) NSArray* hours;

- (id) init;

- (id) initWithHours: (NSArray*) hours;

- (void) loadData: (void (^)(NSError* error, Hours* hoursModel)) block;

- (NSDictionary*) hoursWithTitle: (NSString*) hoursTitle;

//the default hours: summer, spring, winter, fall
- (NSArray*) defaultHours;

//facility hours that are not closed and not default hours
- (NSArray*) facilityHours;

//hours when the rec is closed
- (NSArray*) closedHours;

//pool hours, tennis court hours, bball court hours
- (NSArray*) otherHours;


//vandyrec.hhh/JSON/hours

- (NSDictionary*) currentHours;
- (NSDictionary*) currentHoursForDate:(NSDate*)date;
- (TimeString*) openingTime;
- (TimeString*) closedTime;
- (TimeString*) openingTimeForDate:(NSDate*)date;
- (TimeString*) closedTimeForDate:(NSDate*)date;

- (BOOL) isOpen;
- (BOOL) willOpenLaterToday;
- (BOOL) wasOpenEarlierToday;

- (NSTimeInterval) timeUntilClosed;
- (NSTimeInterval) timeUntilOpen;

//- (NSDictionary*) hoursFromCurrentDay: (NSInteger) offset;

@end


