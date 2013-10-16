//
//  Intramural.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/11/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Intramural : NSObject

@property (nonatomic, strong, readonly) NSArray* teams;
@property (nonatomic, strong, readonly) NSArray* sports;
@property (nonatomic, strong, readonly) NSString* league;
@property (nonatomic, strong, readonly) NSString* name;

//+ (id) intramuralWithData: (NSDictionary*) data;
//- (NSArray*) gamesForDate: (NSArray*) date;
@end
