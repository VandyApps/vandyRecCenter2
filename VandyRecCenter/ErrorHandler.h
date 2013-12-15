//
//  ErrorHandler.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/14/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* NetworkErrorConnection;
extern NSString* NetworkErrorUnknown;

@interface ErrorHandler : NSObject

+ (void) handleError: (NSError*) error withResponse: (NSHTTPURLResponse*) response;

@end
