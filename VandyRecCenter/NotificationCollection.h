//
//  NotificationCollection.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Notification.h"
#import "RecClient.h"

@class NotificationCollection;

@protocol NoticiationDelegate <NSObject>

- (void) notificationAdded: (Notification*) notification atIndex: (NSUInteger) index;
- (void) notificationRemoved: (Notification*) notification fromIndex: (NSUInteger) index;
- (void) collectionCompletedInitialImport: (NotificationCollection*) collection;
@end

@interface NotificationCollection : NSObject


@property (nonatomic, strong, readonly) NSArray* items;
@property (nonatomic, weak) id<NoticiationDelegate> delegate;

#pragma mark - Singleton Instance
+ (NotificationCollection*) sharedInstance;

#pragma mark - adding notifications
- (void) addNotification: (Notification*) notification;
- (void) removeNotificationWithID: (NSString*) ID;
- (void) initialImport;

#pragma mark - convenience methods
- (NSUInteger) count;
@end
