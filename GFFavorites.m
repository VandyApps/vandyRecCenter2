//
//  GFFavorites.m
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFFavorites.h"
#import "GFFavorite.h"



@implementation GFFavorites

static GFFavorites* sInstance;
static NSString* mPathname;
static BOOL isSorted = NO;

- (NSArray*) GFClasses {
    if (_GFClasses == nil) {
        _GFClasses = @[];
    }
    return _GFClasses;
}



+ (GFFavorites*) sharedInstance {
    if (sInstance == nil) {
        sInstance = [[GFFavorites alloc] init];
        [sInstance load];
    }
    return sInstance;
}

- (void) add: (NSDictionary*) GFClass {
    _GFClasses = [self.GFClasses arrayByAddingObject: [[GFFavorite alloc] initWithGFClass: GFClass]];
    if (_GFClasses.count > 1) {
        isSorted = NO;
    }
}
- (void) remove: (NSDictionary*) GFClass {
    for (NSUInteger i = 0; i < self.GFClasses.count; ++i) {
        if ([(GFFavorite*) self.GFClasses[i] isEqualToGFClass: GFClass]) {
            _GFClasses = [[self.GFClasses subarrayWithRange: NSMakeRange(0, i)] arrayByAddingObjectsFromArray: [self.GFClasses subarrayWithRange:NSMakeRange(i+1, _GFClasses.count - i - 1)]];
        }
    }
}

- (void) sort {
    if (!isSorted) {
        [self.GFClasses sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [(GFFavorite*) obj1 compare: (GFFavorite*) obj2];
        }];
        isSorted = YES;
    }
}

- (BOOL) contains: (NSDictionary*) GFClass {
    
    for (GFFavorite* favorite in self.GFClasses) {
        if ([favorite isEqualToGFClass: GFClass]) {
            return YES;
        }
    }
    return NO;
}

//array-like methods
- (GFFavorite*) GFFavoriteForIndex: (NSUInteger) index {
    return [self.GFClasses objectAtIndex: index];
}

- (NSUInteger) count {
    return self.GFClasses.count;
}

#pragma mark - Persistence

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent: @"GFFavorites_Backup.plist"];
}

- (NSArray*) generatePList {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (GFFavorite* favorite in self.GFClasses) {
        [array addObject: favorite.GFClass];
    }
    return [array copy];
}

- (void) parsePList: (NSArray*) plist {
    _GFClasses = [[NSArray alloc] init];
    for (NSDictionary* GFClass in plist) {
        _GFClasses = [_GFClasses arrayByAddingObject: [[GFFavorite alloc] initWithGFClass:GFClass]];
    }
    
}

//wipes current data and loads persisted data
- (void) load {
    if ([[NSFileManager defaultManager] fileExistsAtPath: [self dataFilePath]]) {
        [self parsePList: [[NSArray alloc] initWithContentsOfFile: [self dataFilePath]]];
    }
    isSorted = YES;
    
}
- (void) save {
    [self sort];
    [[self generatePList] writeToFile: [self dataFilePath] atomically: YES];
}


@end
