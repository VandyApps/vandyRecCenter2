//
//  IMLeague.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 2/1/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecModelProtocol.h"

@class  IMTeam;
@class  IMGame;

typedef enum {
    IMLeagueSeasonFall = 1,
    IMLeagueSeasonWinter = 2,
    IMLeagueSeasonSpring = 3,
    IMLeagueSeasonSummer = 0
    
} IMLeagueSeason;

@interface IMLeague : NSObject

@property (nonatomic, strong, readonly) NSString* cid;

@property (nonatomic, strong,readonly) NSDate* entryStartDate;
@property (nonatomic, strong, readonly) NSDate* entryEndDate;

@property (nonatomic, strong, readonly) NSDate* startDate;
@property (nonatomic, strong, readonly) NSDate* endDate;

@property (nonatomic, strong, readonly) NSString* name;
@property (nonatomic, strong,readonly) NSArray* teams;
@property (nonatomic, strong, readonly) NSArray* games;

- (IMTeam*) teamWithId: (NSString*) team;
- (IMGame*) gameWithId: (NSString*) game;

@end
