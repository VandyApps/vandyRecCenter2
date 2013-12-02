//
//  GFCollection.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/26/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFCollection.h"

@interface GFCollection()

@property (nonatomic, strong) GFSpecialDates* specialDates;

@end

@implementation GFCollection

@synthesize models = _models;
@synthesize specialDates = _specialDates;

#pragma mark - Getters
- (NSArray*) models {
    if (_models == nil) {
        _models = [[NSArray alloc] init];
    }
    return _models;
}
- (GFSpecialDates*) specialDates {
    if (_specialDates == nil) {
        _specialDates = [[GFSpecialDates alloc] init];
    }
    return _specialDates;
}

- (GFFavorites*) favorites {
    if (_favorites == nil) {
        _favorites = [[GFFavorites alloc] init];
    }
    return _favorites;
}


#pragma mark - Model Getters
- (void) GFModelForYear:(NSUInteger)year month:(NSUInteger)month block:(void (^)(NSError *error, GFModel *model))block {
  //array of models is in chronological order
    BOOL foundModel = NO;
    for (GFModel* model in self.models) {
        if (model.month == month && model.year == year) {
            foundModel = YES;
            block(nil, model);
        }
    }
    
    if (!foundModel) {
        GFModel * newModel = [[GFModel alloc] init];
        [newModel loadData:^(NSError *error, NSArray *data) {
            if (error) {
                NSLog(@"%@", error);
                block(error, nil);
            } else {
                self.models = [self.models arrayByAddingObject: newModel];
                [self sort];
                block(nil, newModel);
            }
        } forMonth: month andYear: year];
    }
   
    
}
- (void) GFModelForCurrentMonth:(void (^)(NSError *, GFModel *))block {
    NSDate* current = [[NSDate alloc] init];
    NSUInteger month = [current monthForTimeZone: NashvilleTime];
    NSUInteger year = [current yearForTimeZone: NashvilleTime];
    [self GFModelForYear: year month: month block:^(NSError *error, GFModel *model) {
        block(error, model);
    }];
    
}

#pragma mark - Sub-model getters

- (void) GFClassesForYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day block:(void (^)(NSError *, NSArray *))block {
    
    [self GFModelForYear: year month: month block:^(NSError *error, GFModel *model) {
        if (error) {
            block(error, nil);
        } else {
            NSArray* classesForDay = [model GFClassesForDay: day];
            classesForDay = [self filterClasses: classesForDay bySpecialDateForYear: year month:month day: day];
            block(nil,classesForDay);
        }
    }];
}

- (void) GFClassesForCurrentDay:(void (^)(NSError *, NSArray *))block {
    [self GFModelForCurrentMonth:^(NSError *error, GFModel *model) {
        if (error) {
            block(error, nil);
        } else {
            NSDate* current = [[NSDate alloc] init];
            NSUInteger day = [current dayForTimeZone: [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE]];
            NSArray* currentClasses = [model GFClassesForDay: day];
            currentClasses = [self filterClasses: currentClasses bySpecialDateForYear: [current year] month: [current month] day: [current day]];
            block(nil, currentClasses);
        }
    }];
}

- (void) GFClassesForDaysAfterCurrentDay:(NSInteger)days block:(void (^)(NSError *, NSArray *))block {
    
    NSDate* date = [DateHelper currentDateForTimeZone:[NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE]];
    //add days to the date
    date = [date dateByAddingTimeInterval: days * 24 * 60 * 60];
    
    [self GFClassesForYear:[date year] month: [date month] day: [date day] block:^(NSError *error, NSArray *GFClasses) {
        
        block(error, GFClasses);
    }];
}

#pragma mark - Sorting method
//sorts the GFModels in the collection so that they are in chronological
//order
- (void) sort {
    self.models = [self.models sortedArrayUsingComparator:^NSComparisonResult(GFModel* obj1, GFModel* obj2) {
        return ([GFModel compareModel1:obj1 model2: obj2]);
    }];
}

#pragma mark - Loading/Reloading
//loading methods do not need to be called unless a model wants to be
//reloaded.  Getters will automatically load data
- (void) loadMonth:(NSUInteger)month andYear:(NSUInteger)year block:(void (^)(NSError *, GFModel *))block {
    BOOL foundModel = NO;
    for (GFModel* model in self.models) {
        if (model.month == month && model.year == year) {
            foundModel = YES;
            [model loadData:^(NSError *error, NSArray *data) {
                if (error) {
                    block(error, nil);
                } else {
                    block(nil, model);
                }
            } forMonth: month andYear: year];
        }
    }
    
    if (!foundModel) {
        GFModel* newModel = [[GFModel alloc] init];
        [newModel loadData:^(NSError *error, NSArray *data) {
            if (error) {
                block(error, nil);
            } else {
                self.models = [self.models arrayByAddingObject: newModel];
                [self sort];
                block(nil, newModel);
            }
        } forMonth: month andYear: year];
    }
}

- (void) loadCurrentMonth:(void (^)(NSError *, GFModel *))block {
    NSDate *current = [[NSDate alloc] init];
    NSUInteger month = [current monthForTimeZone: [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE]];
    NSUInteger year = [current yearForTimeZone: [NSTimeZone timeZoneWithName: NASHVILLE_TIMEZONE]];
    [self loadMonth: month andYear: year block:^(NSError *error, GFModel *model) {
        if (error) {
            block(error, nil);
        } else {
            block(error, model);
        }
    }];
}

#pragma mark - Query
- (void) getClassForYear: (NSUInteger) year month: (NSUInteger) month ID: (NSString*) ID block: (void(^)(NSError* error, NSDictionary* GFClass)) block {
    
    [self GFModelForYear:year month:month block:^(NSError *error, GFModel *model) {
        if (error) {
            block(error, nil);
        } else {
            for (NSDictionary* GFClass in model.GFClasses) {
                if ([[GFClass objectForKey: @"_id"] isEqualToString: ID]) {
                    block(nil, GFClass);
                }
            }
        }
        
    }];
}

#pragma mark - Validate
- (BOOL) dataLoadedForMonth:(NSUInteger)year year:(NSUInteger)month {
    for (GFModel* model in self.models) {
        NSLog(@"Found model for month %u and year %u", month, year);
        if (model.year == year && model.month == month) {
            return [model dataLoaded];
        }
    }
    return NO;
}


#pragma mark - Private

- (NSArray*) filterClasses: (NSArray*) GFClasses bySpecialDateForYear: (NSUInteger) year month: (NSUInteger) month day: (NSUInteger) day {
    
    __block NSArray* filteredClasses = [[NSArray alloc] init];
    [self.specialDates loadData:^(NSError *error, GFSpecialDates *specialDates) {
        
        
        if ([specialDates isSpecialDateForYear: year month: month day: day]) {
            for (NSDictionary* GFClass in GFClasses) {
                if ([[GFClass objectForKey: @"specialDateClass"] boolValue]) {
                    filteredClasses = [filteredClasses arrayByAddingObject: GFClass];
                }
            }
        } else {
            for (NSDictionary* GFClass in GFClasses) {
                if (![[GFClass objectForKey: @"specialDateClass"] boolValue]) {
                    filteredClasses = [filteredClasses arrayByAddingObject: GFClass];
                }
            }
        }
        
    }];
    return filteredClasses;
}
@end
