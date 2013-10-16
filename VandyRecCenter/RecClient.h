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

//- (void) fetchHours: (void(^)(NSError* error, NSArray* hours)) block;

- (void) fetchGroupFitness: (void(^)(NSError* error, NSArray* classes)) block;
- (void) fetchGroupFitnessForMonth: (NSInteger) month year: (NSInteger) year block:(void (^)(NSError *, NSArray* classes))block;
- (void) fetchGroupFitnessSpecialDates: (void(^)(NSError* error, NSArray* specialDates)) block;


@end
