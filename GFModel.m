//
//  GFModel.m
//  
//
//  Created by Brendan McNamara on 5/26/13.
//
//

#import "GFModel.h"

@interface GFModel()

@property (nonatomic, strong) RecClient* webClient;

@end

@implementation GFModel

@synthesize webClient = _webClient;
@synthesize dataLoaded = _dataLoaded;
@synthesize month = _month;
@synthesize year = _year;


#pragma mark - getters
- (RecClient*) webClient {
    if (_webClient == nil) {
        _webClient = [[RecClient alloc] init];
    }
    return _webClient;
}

#pragma mark - initializers

- (id) init {
    self = [super init];
    return self;
}

#pragma mark load data

- (void) loadData:(void (^)(NSError *, NSArray *))block forMonth:(NSInteger)month andYear:(NSInteger)year {
    if (month < 0 || year < 0) {
        self.month = -1;
        self.year = -1;
        [self.webClient fetchGroupFitness:^(NSError *error, NSArray *classes) {
            
            if (error) {
                block(error, classes);
            } else {
                self.dataLoaded = YES;
                self.GFClasses = classes;
                
                block(nil, classes);
            }
        }];
        
    } else {
        self.month = month;
        self.year = year;
        
        [self.webClient fetchGroupFitnessForMonth: month year: year block:^(NSError *error, NSArray *classes) {
            
            if (error) {
                block(error, nil);
            } else {
                self.dataLoaded = YES;
                self.GFClasses = classes;
                
                block(nil, classes);
            }
        }];
    
    }
    
}


#pragma mark - Public

- (NSArray*) GFClassesForDay:(NSUInteger)day {
    
    //check if the GFModel instance is for a given
    //month
    if (self.month >= 0) {
        
        NSArray *GFClasses = [[NSArray alloc] init];
        for (NSDictionary* GFClass in self.GFClasses) {
            
            if ([self GFClass: GFClass isOnDay: day]) {
                GFClasses = [GFClasses arrayByAddingObject: GFClass];
                
            }
        }
        
        GFClasses = [GFClasses sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSString* timeString1 = [[[obj1 objectForKey: @"timeRange"] componentsSeparatedByString: @" - "] objectAtIndex: 0];
            
            NSString *timeString2 = [[[obj2 objectForKey: @"timeRange"] componentsSeparatedByString: @" - "] objectAtIndex: 0];
           
            TimeString* time1 = [[TimeString alloc] initWithString: timeString1];
            TimeString* time2 = [[TimeString alloc] initWithString: timeString2];
            return [TimeString compareTimeString1: time1 timeString2: time2];
        }];
        
        return GFClasses;
    }
    return nil;
}



- (BOOL) GFClass: (NSDictionary*) GFClass isOnDay: (NSUInteger) day {
    
    NSDate *date = [NSDate dateWithYear: self.year month: self.month andDay: day];
    
    if ([[GFClass objectForKey: @"dayOfWeek"] intValue] != (NSInteger) date.weekDay) {
       
        return NO;
    }
    
    
    NSArray* startDateArray = [[GFClass objectForKey: @"startDate"] componentsSeparatedByString: @"/"];

    NSDate* startDate = [NSDate dateWithYear: [[startDateArray objectAtIndex: 2] intValue]  month:[[startDateArray objectAtIndex: 0] intValue] - 1 andDay:[[startDateArray objectAtIndex: 1] intValue]];
    if ([startDate compare: date] == NSOrderedDescending) {
        return NO;
    }
    NSString* endDateString = [GFClass objectForKey: @"endDate"];
    if (![endDateString isEqualToString: @"*"]) {
        NSArray* endDateArray = [endDateString componentsSeparatedByString: @"/"];
        NSDate* endDate = [NSDate dateWithYear: [[endDateArray objectAtIndex: 2] intValue] month: [[endDateArray objectAtIndex: 0] intValue] - 1 andDay: [[endDateArray objectAtIndex: 1] intValue] ];
        if ([date compare: endDate] == NSOrderedDescending) {
            return NO;
        }
    }
    
    
    return YES;
}
#pragma mark Current Time


- (NSDictionary*) currentGFClass {
    NSDate *currentDate = [[NSDate alloc] init];
    if (self.month == [currentDate monthForTimeZone: NashvilleTime] && self.year == [currentDate yearForTimeZone: NashvilleTime]) {
        
        NSArray* GFClasses = [self GFClassesForDay: [currentDate dayForTimeZone: NashvilleTime]];
        for (NSDictionary* GFClass in GFClasses) {
            NSArray* arrayOfTimes = [[GFClass objectForKey: @"timeRange"] componentsSeparatedByString: @" - "];
            TimeString* start = [[TimeString alloc] initWithString: [arrayOfTimes objectAtIndex: 0]];
            TimeString* end = [[TimeString alloc] initWithString: [arrayOfTimes objectAtIndex: 1]];
            TimeString* current = [[TimeString alloc] initWithTimeZone: NashvilleTime];
            if ([TimeString compareTimeString1: start timeString2: current] != NSOrderedDescending && [TimeString compareTimeString1: end timeString2: current] != NSOrderedAscending) {
                return GFClass;
            }
        }
    }
    return nil;
}

#pragma mark  Comparison

+(NSComparisonResult) compareModel1:(GFModel *)model1 model2:(GFModel *)model2 {
    if (model1.year > model2.year) {
        return NSOrderedDescending;
    } else if (model1.year < model2.year) {
        return NSOrderedAscending;
    } else { //equal years
        if (model1.month > model2.month) {
            return NSOrderedDescending;
        } else if (model1.month < model2.month) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }
}

- (BOOL) precedesModel:(GFModel *)model {
    if (model.year < self.year) {
        return YES;
    } else if (model.year == self.year && model.month < self.month) {
        return YES;
    }
    return NO;
}

#pragma mark - Description

- (NSString*) description {
    return [NSString stringWithFormat: @"%@", self.GFClasses];
}
@end
