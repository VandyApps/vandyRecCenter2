//
//  GFCollection.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFModel.h"
#import "GFSpecialDates.h"
#import "GFFavorites.h"
#import "NSDate-MyDateClass.h"
#import "DateHelper.h"


@interface GFCollection : NSObject

@property (nonatomic, strong) NSArray* models;
@property (nonatomic, strong) GFFavorites* favorites;


//loads the collection with a single element
//in the model array that represents the current date
- (void) loadCurrentMonth: (void(^)(GFModel* model)) block;

- (void) loadMonth: (NSUInteger) month andYear: (NSUInteger) year block: (void(^)(GFModel* model)) block;


- (BOOL) dataLoadedForMonth: (NSUInteger) year year: (NSUInteger) month;

//gets the classes for the current day
//if the GFClasses for the the day have not
//loaded, they are loaded before calling the block
- (void) GFClassesForCurrentDay: (void (^)(NSArray* GFClasses)) block;

//if a negative number is passed in, this will
//return the GFClasses for that many days before
//the current day
- (void) GFClassesForDaysAfterCurrentDay: (NSInteger) days block: (void (^)(NSArray* GFClasses)) block;
- (void) GFClassesForYear: (NSUInteger) year month: (NSUInteger) month day: (NSUInteger) day block: (void (^)(NSArray* GFClasses)) block;

- (void) GFModelForCurrentMonth: (void (^)(GFModel *model)) block;
- (void) GFModelForYear: (NSUInteger) year month: (NSUInteger) month block: (void (^)(GFModel* model)) block;

//querying for a single class
- (void) getClassForYear: (NSUInteger) year month: (NSUInteger) month ID: (NSString*) ID block: (void(^)(NSDictionary* GFClass)) block;


@end
