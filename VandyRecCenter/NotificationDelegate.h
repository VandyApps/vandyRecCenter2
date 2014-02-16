//
//  NotificationDelegate.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 2/16/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NotificationCollection;
@class Notification;

@protocol NoticiationDelegate <NSObject>

- (void) notificationAdded: (Notification*) notification atIndex: (NSUInteger) index;
- (void) notificationRemoved: (Notification*) notification fromIndex: (NSUInteger) index;
- (void) collectionCompletedInitialImport: (NotificationCollection*) collection;
@end

