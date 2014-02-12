//
//  RecClient.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "RecClient.h"
#import "ErrorHandler.h"

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
- (void) fetchNews:(void (^)(NSArray*))block {
    [self GET: @"news" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    block((NSArray*) responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ErrorHandler handleError: error withResponse: operation.response];
    }];
}

- (void) fetchHours:(void (^)(NSError *, NSArray *))block {
    [self GET:@"hours" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(nil, (NSArray*) responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ErrorHandler handleError: error withResponse: operation.response];
            block(error, nil);
            
        }];
}

- (void) fetchGroupFitness:(void (^)(NSArray*))block {
    
    [self GET: @"GF" parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block((NSArray*) responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ErrorHandler handleError: error withResponse: operation.response];
    }];
}

- (void) fetchGroupFitnessForMonth:(NSInteger)month year:(NSInteger)year block:(void (^)(NSArray*))block {

    NSDictionary* params = @{@"type":@"GFClass",
                             @"month": @(month),
                             @"year": @(year)};
    
    [self GET: @"GF" parameters: params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block((NSArray*) responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ErrorHandler handleError: error withResponse:operation.response];
    }];
}

- (void) fetchGroupFitnessSpecialDates:(void (^)(NSArray *))block {
    NSDictionary* params = @{@"type": @"GFSpecialDate"};
    
    [self GET: @"GF" parameters: params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block((NSArray*) responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ErrorHandler handleError: error withResponse: operation.response];
    }];
}

@end
