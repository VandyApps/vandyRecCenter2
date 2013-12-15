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


#pragma mark - Model Getters
- (void) GFModelForYear:(NSUInteger)year month:(NSUInteger)month block:(void (^)(GFModel *model))block {
  //array of models is in chronological order
    BOOL foundModel = NO;
    for (GFModel* model in self.models) {
        if (model.month == month && model.year == year) {
            foundModel = YES;
            block(model);
        }
    }
    
    if (!foundModel) {
        GFModel * newModel = [[GFModel alloc] init];
        [newModel loadData:^(NSArray *data) {
            
            self.models = [self.models arrayByAddingObject: newModel];
            [self sort];
            block(newModel);
        } forMonth: month andYear: year];
    }
   
    
}
- (void) GFModelForCurrentMonth:(void (^)(GFModel *))block {
    NSDate* current = [[NSDate alloc] init];
    NSUInteger month = [current monthForTimeZone: NashvilleTime];
    NSUInteger year = [current yearForTimeZone: NashvilleTime];
    [self GFModelForYear: year month: month block:^(GFModel *model) {
        block(model);
    }];
    
}

#pragma mark - Sub-model getters

- (void) GFClassesForYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day block:(void (^)(NSArray *))block {
    
    [self GFModelForYear: year month: month block:^(GFModel *model) {
        
        NSArray* classesForDay = [model GFClassesForDay: day];
        
        classesForDay = [self filterClasses: classesForDay bySpecialDateForYear: year month:month day: day];
        
        block(classesForDay);
        
    }];
}

- (void) GFClassesForCurrentDay:(void (^)(NSArray *))block {
    [self GFModelForCurrentMonth:^(GFModel *model) {
        
        NSDate* current = [[NSDate alloc] init];
        NSUInteger day = [current dayForTimeZone: NashvilleTime];
        NSArray* currentClasses = [model GFClassesForDay: day];
        currentClasses = [self filterClasses: currentClasses bySpecialDateForYear: [current year] month: [current month] day: [current day]];
        block(currentClasses);
    }];
}

- (void) GFClassesForDaysAfterCurrentDay:(NSInteger)days block:(void (^)(NSArray *))block {
    
    NSDate* date = [DateHelper currentDateForTimeZone: NashvilleTime];
    //add days to the date
    date = [date dateByAddingTimeInterval: days * 24 * 60 * 60];
    
    [self GFClassesForYear:[date year] month: [date month] day: [date day] block:^(NSArray *GFClasses) {
        
        block(GFClasses);
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
- (void) loadMonth:(NSUInteger)month andYear:(NSUInteger)year block:(void (^)(GFModel *))block {
    //load special dates before trying to do anything else
    [self loadSpecialDates:^{
        
        BOOL foundModel = NO;
        for (GFModel* model in self.models) {
            if (model.month == month && model.year == year) {
                foundModel = YES;
                [model loadData:^(NSArray *data) {
                    block(model);
                } forMonth: month andYear: year];
            }
        }
        
        if (!foundModel) {
            
            GFModel* newModel = [[GFModel alloc] init];
            [newModel loadData:^(NSArray *data) {
                self.models = [self.models arrayByAddingObject: newModel];
                [self sort];
                block(newModel);
                
            } forMonth: month andYear: year];
        }
    }];
    
}

- (void) loadCurrentMonth:(void (^)(GFModel *)) block {
    NSDate *current = [[NSDate alloc] init];
    NSUInteger month = [current monthForTimeZone: NashvilleTime];
    NSUInteger year = [current yearForTimeZone: NashvilleTime];
    [self loadMonth: month andYear: year block:^(GFModel *model) {
        block(model);
    }];
}

#pragma mark - Query
- (void) getClassForYear: (NSUInteger) year month: (NSUInteger) month ID: (NSString*) ID block: (void(^)(NSDictionary* GFClass)) block {
    
    [self GFModelForYear:year month:month block:^(GFModel *model) {
        for (NSDictionary* GFClass in model.GFClasses) {
            if ([[GFClass objectForKey: @"_id"] isEqualToString: ID]) {
                block(GFClass);
            }
        }
    }];
}

#pragma mark - Validate
- (BOOL) dataLoadedForMonth:(NSUInteger)month year:(NSUInteger)year {
    for (GFModel* model in self.models) {
        if (model.year == year && model.month == month) {
            return [model dataLoaded];
        }
    }
    return NO;
}


#pragma mark - Private
- (void) loadSpecialDates: (void(^)()) block {
    static BOOL isLoaded = NO;
    
    if (!isLoaded) {
        
        [self.specialDates loadData:^(GFSpecialDates *specialDates) {
            isLoaded = YES;
            
            block();
        }];
    } else {
        
        block();
    }
    
}

/*SHOULD CALL LOAD SPECIALDATES BEFORE THIS METHOD IS CALLED FOR IT TO WORK PROPERLY*/
- (NSArray*) filterClasses: (NSArray*) GFClasses bySpecialDateForYear: (NSUInteger) year month: (NSUInteger) month day: (NSUInteger) day {
    
    NSArray* filteredClasses = [[NSArray alloc] init];
    
    if ([self.specialDates isSpecialDateForYear: year month: month day: day]) {
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
    return filteredClasses;
}
@end
