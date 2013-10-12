//
//  GFFavorites.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFFavorites.h"

@implementation GFFavorites

@synthesize GFClasses = _favorites;



- (NSArray*) GFClasses {
    if (_favorites == nil) {
        _favorites = [[NSArray alloc] init];
    }
    return _favorites;
}
- (void) add:(NSDictionary *)GFClass {
    if (![self isFavorite: GFClass]) {
        self.GFClasses = [self.GFClasses arrayByAddingObject: GFClass];
        [self sort];
        NSLog(@"%@", self.GFClasses);
    }
}

- (void) removeGFClassWithID:(NSString *)ID {
    for (NSUInteger i = 0; i < self.GFClasses.count; ++i) {
        if ([[[self.GFClasses objectAtIndex: i] objectForKey: @"_id"] isEqualToString: ID]) {
            if (i == 0) {
                self.GFClasses = [self.GFClasses subarrayWithRange: NSMakeRange(1, self.GFClasses.count - 1)];
            } else if (i == self.GFClasses.count - 1) {
                self.GFClasses = [self.GFClasses subarrayWithRange: NSMakeRange(0, self.GFClasses.count - 1)];
            } else {
                NSArray* partial1 = [self.GFClasses subarrayWithRange: NSMakeRange(0, i)];
                NSArray* partial2 = [self.GFClasses subarrayWithRange: NSMakeRange(i+1, self.GFClasses.count - i - 1)];
                self.GFClasses = partial1;
                self.GFClasses = [self.GFClasses arrayByAddingObjectsFromArray: partial2];
            }
        }
    }
    NSLog(@"%@", self.GFClasses);
}

- (NSDictionary*) GFClassWithID: (NSString*) ID {
    for (NSDictionary* GFClass in self.GFClasses) {
        if ([[GFClass objectForKey: @"_id"] isEqualToString: ID]) {
            return GFClass;
        }
    }
    return nil;
}

- (void) sort {
    self.GFClasses = [self.GFClasses sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* startDate1 = [obj1 objectForKey: @"startDate"];
        NSString* startDate2 = [obj2 objectForKey: @"startDate"];
        NSArray* dateArray1 = [startDate1 componentsSeparatedByString: @"/"];
        NSArray* dateArray2 = [startDate2 componentsSeparatedByString: @"/"];
        if ([[dateArray1 objectAtIndex: 2] intValue] < [[dateArray2 objectAtIndex: 2] intValue]) {
            return NSOrderedAscending;
        } else if ([[dateArray1 objectAtIndex: 2] intValue] > [[dateArray2 objectAtIndex: 2] intValue]) {
            return NSOrderedDescending;
        } else {
            //same year
            NSString* time1 = [obj1 objectForKey: @"timeRange"];
            NSString* startTime1 = [[time1 componentsSeparatedByString: @" - "] objectAtIndex:0];
            
            NSString* time2 = [obj2 objectForKey: @"timeRange"];
            NSString* startTime2 = [[time2 componentsSeparatedByString: @" - "] objectAtIndex:0];
            TimeString* timeString1 = [[TimeString alloc] initWithString:  startTime1];
            TimeString* timeString2 = [[TimeString alloc] initWithString: startTime2];
            return [TimeString compareTimeString1: timeString1 timeString2: timeString2];
        }
    }];
}

- (BOOL) isFavorite:(NSDictionary *)GFClass {
    for (NSDictionary* favClass in self.GFClasses) {
        if ([[GFClass objectForKey: @"_id"] isEqualToString: [favClass objectForKey: @"_id"]]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Array-like methods
- (NSDictionary*) GFClassForIndex:(NSUInteger)index {
    return [self.GFClasses objectAtIndex: index];
}

- (NSUInteger) count {
    return self.GFClasses.count;
}


#pragma mark - Persistant Data

//saves data to a property list
- (void) saveData {
    //implement CORE DATA to save favorites list
}

- (void) loadData {
    //implement CORE DATA to load favorites list
}
@end
