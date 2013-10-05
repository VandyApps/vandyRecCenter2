//
//  Notification.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    //this enum is in order of importance
    NotificationTypeNews = 1,
    NotificationTypeGroupFitness = 2,
    NotificationTypeIntramurals = 3,
    NotificationTypeHours = 4,
    
} NotificationType;

@interface Notification : NSObject

@property (nonatomic, readonly) NotificationType type;
@property (nonatomic, readonly) NSString* message;
@property (nonatomic, readonly) NSInteger priority;
@property (nonatomic, readonly) NSString* ID;

- (id) initWithType: (NotificationType) type message: (NSString*) message priority: (NSInteger) priority;

@end
