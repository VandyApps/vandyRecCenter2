//
//  Hours.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
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
- (TimeString*) openingTime;
- (TimeString*) closedTime;

- (BOOL) isOpen;
- (BOOL) willOpenLaterToday;
- (BOOL) wasOpenEarlierToday;

- (NSTimeInterval) timeUntilClosed;
- (NSTimeInterval) timeUntilOpen;

@end


