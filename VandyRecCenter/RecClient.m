//
//  RecClient.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "RecClient.h"

@implementation RecClient
static RecClient* client;
static BOOL initialized = NO;


#pragma mark - Initialization
- (id) init {
    self = [super initWithBaseURL: [NSURL URLWithString: BASE_URL]];
    if (self) {
        //additional setup here
    }
   return self;
}

+ (id) sharedClient {
    if (!initialized) {
        client = [[RecClient alloc] init];
    }
    return client;
}

#pragma mark - Fetch methods
- (void) fetchNews:(void (^)(NSError *, NSArray*))block {
    [self GET: @"news" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    block(nil, (NSArray*) responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed");
        NSLog(@"%@", operation.responseString);
        block(error, nil);
    }];
}
@end
