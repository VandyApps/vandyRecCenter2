//
//  DateHelper.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate-MyDateClass.h"
@interface DateHelper : NSObject

+ (NSDate*) currentDateForTimeZone: (NSTimeZone*) timezone;

+ (NSString*) monthNameForIndex: (NSUInteger) index;
+ (NSString*) monthNameAbbreviationForIndex: (NSUInteger) index;
+ (NSString*) weekDayForIndex: (NSUInteger) index;
+ (NSString*) weekDayAbbreviationForIndex: (NSUInteger) index;

+ (NSUInteger) daysForMonth: (NSUInteger) month year: (NSUInteger) year;
@end
