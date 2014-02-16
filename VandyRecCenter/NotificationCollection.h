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
#import "NotificationDelegate.h"

@class NotificationCollection;



@interface NotificationCollection : NSObject

@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, strong, readonly) NSArray* items;
@property (nonatomic, weak) id<NoticiationDelegate> delegate;


+ (NotificationCollection*) sharedInstance;


- (void) addNotification: (Notification*) notification;
- (void) removeNotification: (Notification*) notification;
- (void) removeNotificationWithID: (NSString*) ID;
- (void) initialImport;

@end
