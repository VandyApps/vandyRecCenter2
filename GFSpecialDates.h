//
//  GFSpecialDates.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 6/2/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecClient.h"
#import "NSDate-MyDateClass.h"

@interface GFSpecialDates : NSObject

@property (nonatomic, strong) NSArray* specialDates;

//loads the data and places the data within the specialDates property
//if this is called subsequently after the load, then it does not
//connect to the web client but just calls the block
//this method must be called before calling any other methods
//in this class
- (void) loadData: (void(^)(NSError* error, GFSpecialDates* specialDates)) block;

//for finding out if the given date has a special date or not
- (BOOL) isSpecialDateForDate: (NSDate*) date;

//for finding out if the given year, day, month has a special date or not
- (BOOL) isSpecialDateForYear: (NSUInteger) year month: (NSUInteger) month day: (NSUInteger) day;

//returns a special date that exists during the passed in date parameter
//returns nil if the date has no special date
- (NSDictionary*) specialDateForDate: (NSDate*) date;

//returns a special date that exists during the year, day, month
//alternative method to the above method, which takes a NSDate object
//returns nil if the date has no special date
- (NSDictionary*) specialDateForYear: (NSUInteger) year month: (NSUInteger) month day: (NSUInteger) day;


@end
