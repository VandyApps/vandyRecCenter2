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

- (void) load {
    
}
- (void) save {
    
}


+ (GFFavorites*) sharedInstance {
    if (sInstance) {
        sInstance = [[GFFavorites alloc] init];
    }
    return sInstance;
}

- (void) add: (NSDictionary*) GFClass {
    _GFClasses = [self.GFClasses arrayByAddingObject: GFClass];
}
- (void) remove: (NSDictionary*) GFClass {
    for (NSUInteger i = 0; i < self.GFClasses.count; ++i) {
        if ([(GFFavorite*) self.GFClasses[i] isEqualToGFClass: GFClass]) {
            _GFClasses = [[self.GFClasses subarrayWithRange: NSMakeRange(0, i)] arrayByAddingObjectsFromArray: [self.GFClasses subarrayWithRange:NSMakeRange(i+1, _GFClasses.count - i - 1)]];
        }
    }
}

- (void) sort {
    [self.GFClasses sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(GFFavorite*) obj1 compare: (GFFavorite*) obj2];
    }];
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
- (NSDictionary*) GFClassForIndex: (NSUInteger) index {
    return [self.GFClasses objectAtIndex: index];
}

- (NSUInteger) count {
    return self.GFClasses.count;
}
@end
