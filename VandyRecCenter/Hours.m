//
//  Hours.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "Hours.h"
#import "TimeString.h"
#import "RecClient.h"

@implementation Hours


- (void) loadData:(void (^)(NSError* error, Hours* hoursModel))block {
    RecClient* webClient = [RecClient sharedClient];
    
    [webClient fetchHours:^(NSError *error, NSArray *hours) {
        if (!error) {
            _hours = hours;
           
        }
        block(error, self);
    }];
}


@end
