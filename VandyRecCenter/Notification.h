//
//  Notification.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * NotificationType enum.
 * An enum that represents the type of notification
 * being represented by an instance
 */
typedef enum {
    //this enum is in order of importance
    NotificationTypeNews = 1,
    NotificationTypeGroupFitness = 2,
    NotificationTypeIntramurals = 3,
    NotificationTypeHours = 4,
    
} NotificationType;

/**
 * used for encapsulating a single notification
 * and helps categorize the notification based on 
 * relevance to the person and time
 */
@interface Notification : NSObject

/**
 * readonly property that represents the type of the Notification
 * @see NotificationType
 */
@property (nonatomic, readonly) NotificationType type;

/**
 * a string that represents the actual notification for the user
 */
@property (nonatomic, readonly) NSString* message;

/**
 * the readonly priority number assigned to this notification,
 * used to helper sort by relevance
 */
@property (nonatomic, readonly) NSInteger priority;

/**
 * an readonly ID property, a unique ID for the notification 
 * to identify it from others
 */
@property (nonatomic, readonly) NSString* ID;

/**
 * Default Initializer
 * @param type A NotificationType enum
 * @param message An NSString message that represents the message for the notification
 * @param priority The priority number of the notification, lowest possible value should be 0,
 * a low priority number indicates greater priority over other Notification
 * @return An instance of the Notification Class
 */
- (id) initWithType: (NotificationType) type message: (NSString*) message priority: (NSInteger) priority;

@end
