//
//  NotificationCollection.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "NotificationCollection.h"


@implementation NotificationCollection


@synthesize items = _items;
@synthesize  delegate = _delegate;

static NotificationCollection* collection;
static BOOL initialized = NO;


+ (id) sharedInstance {
    
    if (!initialized) {
        collection = [[NotificationCollection alloc] init];
        initialized = YES;
    }
    return collection;
}

#pragma mark - Async
- (void) initialImport {
    [[RecClient sharedClient] fetchNews:^(NSError *error, NSArray* news) {
        if (error == nil) {
            _items = [[NSArray alloc] init];
            for (NSUInteger i = 0; i < news.count; ++i) {
                NSDictionary* newsElement = [news objectAtIndex: i];
                
                _items = [_items arrayByAddingObject:[[Notification alloc] initWithType: NotificationTypeNews message: [newsElement objectForKey: @"description"] priority: [[newsElement objectForKey: @"priorityNumber"] intValue]]];
            }
            //sort after appending all the elements
            [self sortItems];

        }
        
        //call block to signify completion
        if (self.delegate) {
            [self.delegate collectionCompletedInitialImport: self];
        }
    }];
}

#pragma mark - Manage Notifications

#pragma mark - Convenience Methods
- (NSUInteger) count {
    return (_items) ? _items.count : 0;
}

#pragma mark - Array Sorting
- (void) sortItems {
    _items = [_items sortedArrayUsingComparator:^NSComparisonResult(Notification* obj1, Notification* obj2) {
        NSUInteger priority1 = obj1.priority * (NSInteger) obj1.type;
        NSUInteger priority2 = obj2.priority * (NSInteger) obj2.type;
        if (priority1 < priority2) {
            return NSOrderedAscending;
        } else if (priority1 > priority2) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
}
@end
