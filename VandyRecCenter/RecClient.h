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

- (void) fetchNews: ( void (^)(NSArray* news)) block;

- (void) fetchHours: (void(^)(NSError* error, NSArray* hours)) block;

- (void) fetchGroupFitness: (void(^)(NSArray* classes)) block;
- (void) fetchGroupFitnessForMonth: (NSInteger) month year: (NSInteger) year block:(void (^)(NSArray* classes))block;
- (void) fetchGroupFitnessSpecialDates: (void(^)(NSArray* specialDates)) block;


@end
