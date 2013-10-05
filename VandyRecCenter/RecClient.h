//
//  RecClient.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

#define BASE_URL @"http://vandyrec.herokuapp.com/JSON"
@interface RecClient : AFHTTPRequestOperationManager

+ (id) sharedClient;

- (void) fetchNews: ( void (^)(NSError* error, NSArray* news)) block;

- (void) fetchHours: (void(^)(NSError* error, id JSON)) block;

- (void) fetchGroupFitness: (void(^)(NSError* error, id JSON)) block;

- (void) fetchIntramurals: (void(^)(NSError* error, id JSON)) block;

- (void) fetchPrograms: (void(^)(NSError* error, id JSON)) block;

- (void) fetchTraffic: (void(^)(NSError* error, id JSON)) block;
@end
