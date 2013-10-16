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
- (void) addNotification:(Notification *)notification {
    //find insertion spot of notification
    NSInteger index = 0;
    while (index < self.items.count && [(Notification*)[self.items objectAtIndex: index] priority] < notification.priority) {
    
        index++;
    }
    
    if (index == self.items.count) {
        _items = [self.items arrayByAddingObject: notification];
    } else {
        _items = [[[self.items subarrayWithRange: NSMakeRange(0, index)] arrayByAddingObject: notification] arrayByAddingObjectsFromArray: [self.items subarrayWithRange: NSMakeRange(index, self.items.count - index)]];
    }
}

- (void) removeNotificationWithID:(NSString *)ID {
    NSUInteger index = 0;
    while (index < self.items.count && ![ID isEqualToString: [(Notification*)[self.items objectAtIndex: index] ID]]) {
    
        index++;
    }
    
    //check if the index does not fall off the end
    if (index != self.items.count) {
        _items = [[_items subarrayWithRange: NSMakeRange(0, index)] arrayByAddingObjectsFromArray:[_items subarrayWithRange: NSMakeRange(index + 1, self.items.count - index - 1)]];
    }
}


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
