//
//  GFModel.h
//  
//
//  Created by Brendan McNamara on 5/26/13.
//
//

#import <Foundation/Foundation.h>
#import "RecClient.h"
#import "NSDate-MyDateClass.h"
#import "TimeString.h"

@interface GFModel : NSObject

//YES if data has been successfully loaded
//if dataLoaded is NO, most methods below, with
//the exception of the method loadData, will do nothing
//and return nil
@property (nonatomic) BOOL dataLoaded;
//GFClasses that have been loaded
@property (nonatomic, strong) NSArray* GFClasses;
//the month and year that the data is in
//negative numbers if the data for this instance consists of all
//classes for the month
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger year;


- (id) init;

//loads the data and return the data and any error to the block
//if month or year are set to a negative number, the data being loaded
//will contain ALL of the GF data available with no month or year
//boundaries
- (void) loadData: (void (^)(NSError* error, NSArray* data)) block forMonth: (NSInteger) month andYear: (NSInteger) year;


//returns true if the class is on the day for the month and year
//of this GFModel instance.  Does not take into account whether
//the class is marked as canceled or not and does not account for
//special dates of the courses.  Special dates are further filtered out
//when this function passes through GFCollection
- (BOOL) GFClass: (NSDictionary*) GFClass isOnDay: (NSUInteger) day;

//this method should only be used when month and year are non-negative numbers
//and the model represents data that consists of a single month
//this returns an array of classes that are on a specific day
//the array is sorted based on the times the classes are held
//such that classes that start earlier in the day come first
- (NSArray*) GFClassesForDay: (NSUInteger) day;


//returns the current class being held
//if there are no classes at the moment or if
//the instance of model is not at the current month or
//year, this will return nil
- (NSDictionary*) currentGFClass;

//comparing models for chronological order
+ (NSComparisonResult) compareModel1: (GFModel*) model1 model2: (GFModel*) model2;

- (BOOL) precedesModel: (GFModel*) model;
@end
