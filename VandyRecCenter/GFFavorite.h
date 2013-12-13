//
//  GFFavorite.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/12/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeString.h"

@interface GFFavorite : NSObject

@property (nonatomic, strong, readonly) NSString* identification;
@property (nonatomic, copy) NSDictionary* GFClass;

@property (nonatomic) NSString* className;
@property (nonatomic) NSString* instructor;
@property (nonatomic) NSString* location;
@property (nonatomic) NSDate* startDate;
@property (nonatomic) NSDate* endDate;

@property (nonatomic) BOOL oneDayClass;
@property (nonatomic) NSUInteger weekDay;

@property (nonatomic, strong) TimeString* startTime;
@property (nonatomic, strong) TimeString* endTime;

@property (nonatomic, strong) NSArray* cancelledDates;


- (id) initWithGFClass: (NSDictionary*) GFClass;
- (BOOL) isEqualToGFClass: (NSDictionary*) GFClass;

- (NSComparisonResult) compare: (GFFavorite*) favorite;

@end
