//
//  ErrorHandler.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/14/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "ErrorHandler.h"

NSString* NetworkErrorConnection = @"NetworkErrorConnection";
NSString* NetworkErrorUnknown = @"NetworkErrorUnknown";

@implementation ErrorHandler


+ (void) handleError:(NSError *)error withResponse:(NSHTTPURLResponse *)response
{
    [[NSNotificationCenter defaultCenter] postNotificationName: NetworkErrorConnection
                                                        object: [self tokenForError:
                                                                 error withResponse: response]];
}

+ (NSDictionary*) tokenForError: (NSError*) error withResponse: (NSHTTPURLResponse*) response
{
    return @{};
}
@end
