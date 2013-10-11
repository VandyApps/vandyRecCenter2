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

- (void) fetchGroupFitness:(void (^)(NSError *, NSArray*))block {
    [self GET: @"GF" parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(nil, (NSArray*) responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(error, nil);
    }];
}

- (void) fetchGroupFitnessForMonth:(NSInteger)month year:(NSInteger)year block:(void (^)(NSError *, NSArray*))block {

    NSDictionary* params = @{@"type":@"GFClass",
                             @"month": @(month),
                             @"year": @(year)};
    
    [self GET: @"GF" parameters: params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(nil, (NSArray*) responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(error, nil);
    }];
}

- (void) fetchGroupFitnessSpecialDates:(void (^)(NSError *, NSArray *))block {
    NSDictionary* params = @{@"type": @"GFSpecialDate"};
    
    [self GET: @"GF" parameters: params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(nil, (NSArray*) responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(error, nil);
    }];
}
@end
