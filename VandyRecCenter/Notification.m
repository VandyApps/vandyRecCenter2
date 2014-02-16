//
//  Notification.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "Notification.h"

@implementation Notification


@synthesize id = _id;
@synthesize message = _message;
@synthesize type = _type;
@synthesize priority = _priority;

- (id) initWithType:(NotificationType)type message:(NSString *)message priority:(NSInteger)priority {
    self = [super init];
    if (self) {
    
        //create a unique ID for the notification
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        _id =  (__bridge NSString *)uuidStringRef;
        
        //set other properties
        _message = message;
        _priority = priority;
        _type = type;
    }
    return self;
}
@end
